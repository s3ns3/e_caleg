import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/utils/cipher_util.dart';
import 'package:e_caleg/vo/http_response_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:path/path.dart' as path;

class AppsNetworkHttp {
  static const tag = 'AppsNetworkHttp';

  static final AppsNetworkHttp _instance = AppsNetworkHttp._();

  static AppsNetworkHttp get() => _instance;

  late Dio _dio;
  String kEngineUrl = foundation.kDebugMode?kEngineUrlDebug:kEngineUrlRelease;
  AppsNetworkHttp._() {
    _dio = Dio(BaseOptions(
      baseUrl: kEngineUrl,
      connectTimeout: kHttpTimeoutConnect,
    ));
    if (kAllowAllSsl) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (httpClient) {
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
        return httpClient;
      };
    } // kAllowAllSsl
//    _dio.interceptors.add(LogInterceptor(responseBody: false));

  } // constructor AppsNetworkHttp

  Future<Uint8List?> downloadFileFromServer({required Map<String, String> headers,
      required String bodyContent, required String encKey}) async {
    try {
      debugPrint('[$tag] downloadFileFromServer: $kEngineUrl, headers: $headers');

      HttpResponseData resp = _generateEncKey(headers, encKey);
      if (resp.rc != rcSuccess) return null;
      String wholeKey = resp.message;
      String encBodyContent = encryptAesCbcWithSha256ToHexa(bodyContent, wholeKey);

      Uint8List? imageByte;
      Response response = await _dio.post('',
          options: Options(
              receiveTimeout: kHttpTimeoutForImage,
              headers: headers,
              responseType: ResponseType.bytes), data: encBodyContent);
      if (response.statusCode == 200 || response.statusCode == 201) {
        imageByte = response.data;
      } else {
        debugPrint('[$tag] HTTP Error ${response.statusCode}');
        imageByte = null;
      }
      // not close here, since the client still in use in global scope
//      _dio.close();

      return imageByte;
    } catch (ex) {
      debugPrint('[$tag] Exception downloadFileFromServer $kEngineUrl, exception: $ex');
      return null;
    }
  } // loadImageFromServer

  Future<HttpResponseData> sendPostRequestToServer({required String endPoint,required Map<String, String> headers,
      Map<String, File>? files, required String bodyContent,
      // required String encKey,
      int timeout = kHttpTimeoutForPost}) async {
    try {
      debugPrint('[$tag] sendPostRequestToServer: $kEngineUrl$endPoint, headers: $headers body: $bodyContent');

      // HttpResponseData resp = _generateEncKey(headers, encKey);
      // if (resp.rc != rcSuccess) return resp;
      // String wholeKey = resp.message;
      // debugPrint('[$tag] using key $wholeKey');
      // String encBodyContent = encryptAesCbcWithSha256ToHexa(bodyContent, wholeKey);

      HttpResponseData httpResponseData;
      Response response;
      if (files == null) {
        response = await _dio.post(endPoint,
            options: Options(
                receiveTimeout: timeout,
                headers: headers,
                responseType: ResponseType.json), data: bodyContent);
      } else {
        Map<String, dynamic> mapContent = {};
        mapContent['data'] = bodyContent;
        mapContent.addAll(files.map((key, value) {
          String filename = path.basename(value.path);
          return MapEntry(key,
              MultipartFile.fromBytes(value.readAsBytesSync(),
                  filename: filename)
          );
        }));
        FormData formData = FormData.fromMap(mapContent);
        response = await _dio.post(endPoint,
            options: Options(
                receiveTimeout: timeout,
                headers: headers,
                responseType: ResponseType.json), data: formData);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // dio will automatically convert to map, if content-type is application/json
        // String? enc = response.headers.value('X-Enc');
        String plainData = response.toString();
        // if (enc != null && enc == '1') {
          // plainData = decryptAesCbcWithSha256FromHexa(plainData, wholeKey);
        // }
        Map<String, dynamic> map = jsonDecode(plainData);
        httpResponseData = HttpResponseData.fromMap(map);
      } else {
        debugPrint('masuk sini : ${response.data}');
        debugPrint('[$tag] HTTP Error ${response.statusCode}, data: ${response.data}');
        String msg = 'Terjadi masalah pada server - ${response.statusCode}';
        httpResponseData = HttpResponseData(rc: rcServerFailed, message: msg);
      }
      // not close here, since the client still in use in global scope
//      _dio.close();

      return httpResponseData;
    } catch (ex) {
      debugPrint('[$tag] Exception sendPostRequestToServer $kEngineUrl$endPoint, exception: $ex');
      HttpResponseData httpResponseData;
      if (ex is DioError) {
        var dioErrorType = ex.type;
        switch (dioErrorType) {
          case DioErrorType.receiveTimeout:
          case DioErrorType.connectTimeout:
            String msg = 'Terjadi gangguan koneksi. Harap periksa koneksi anda dan silahkan coba lagi';
            httpResponseData =
                HttpResponseData(rc: rcConnectionError, message: msg);
            break;
          case DioErrorType.response:
            String msg = 'Terjadi masalah pada server - ${ex.response?.statusCode}';
            String rc = rcServerFailed;
            dynamic data = ex.response?.data;
            if (data is Map) {
              rc = data['rc'];
              msg = data['message'];
            }

            httpResponseData =  HttpResponseData(rc: rc, message: msg);
            break;
          default: // cancel and general error, include no connection
            String msg = 'Terjadi masalah koneksi. Harap periksa koneksi anda dan silahkan coba lagi';
            httpResponseData =
                HttpResponseData(rc: rcNetworkGeneralError, message: msg);
        }
      } else {
        // general error
        String msg = 'Terjadi masalah koneksi. Harap periksa koneksi anda dan silahkan coba lagi';
        httpResponseData =
            HttpResponseData(rc: rcNetworkGeneralError, message: msg);
      }
      return httpResponseData;
    }
  }

  HttpResponseData _generateEncKey(Map<String, String> headers, String encKey) {
    String? timestamp = headers['X-Timestamp'];
    if (timestamp == null || timestamp == '') {
      debugPrint('[$tag] Unable to get timestamp from headers');
      return HttpResponseData(rc: rcSystemError, message: kAppsMsgErrSystem);
    }
    String wholeKey = timestamp + encKey;
    return HttpResponseData(rc: rcSuccess, message: wholeKey);
  }
}
