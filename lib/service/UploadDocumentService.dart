import 'dart:convert';
import 'dart:io';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/setting_service.dart';
import 'package:e_caleg/utils/apps_network_http.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/document_vo.dart';
import 'package:e_caleg/vo/http_response_data.dart';
import 'package:e_caleg/vo/req_document_vo.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:flutter/cupertino.dart';

class UploadDocumentService {
  static const tag = 'UploadDocumentService';

  static final UploadDocumentService _instance = UploadDocumentService._();
  static UploadDocumentService get() => _instance;

  // List<DocumentVO> _documentVO = [];
  // List<DocumentVO> get documentVO => _documentVO;
  late DocumentResponse _documentResponse;
  DocumentResponse get documentResponse => _documentResponse;

  UploadDocumentService._();

  Future<ServiceResponseVO> requestInit({required String calegTypeId}) async {
    Map<String, String> headers =
        await SettingService.get().createHttpHeaders();
    Map<String, String> reqVO = {
      'calegTypeId': calegTypeId,
    };

    String bodyContent = jsonEncode(reqVO);

    final networkHttp = AppsNetworkHttp.get();
    HttpResponseData httpResponseData =
        await networkHttp.sendPostRequestToServer(
            endPoint: kEndponitDocumentInit,
            headers: headers,
            bodyContent: bodyContent);
    debugPrint('[$tag] --> requestInit $httpResponseData');
    if (httpResponseData.rc == rcSuccess) {
      //map data
      _documentResponse = DocumentResponse.fromJson(httpResponseData.data);
      // _documentVO = documentResponse.listDokumen!;
    }

    debugPrint('[$tag] --> _documentResponse $_documentResponse');

    ServiceResponseVO responseVO =
        ServiceResponseVO(httpResponseData.rc, httpResponseData.message);
    return responseVO;
  }

  Future<ServiceResponseVO> requestUploadDocument({required ReqDocumentVO reqDocumentVO, required File documentPhoto}) async {
    Map<String, String> headers =
    await SettingService.get().createHttpHeaders();
    String bodyContent = jsonEncode(reqDocumentVO);
    Map<String, File> files = {
      'fileDokumen': documentPhoto
    };

    final networkHttp = AppsNetworkHttp.get();
    HttpResponseData httpResponseData =
    await networkHttp.sendPostRequestToServer(
        endPoint: kEndponitDocumentUpload,
        headers: headers,
        files: files,
        bodyContent: bodyContent);
    debugPrint('[$tag] --> requestInit $httpResponseData');
    if (httpResponseData.rc == rcSuccess) {
      //save image n count to db
    }

    ServiceResponseVO responseVO =
    ServiceResponseVO(httpResponseData.rc, httpResponseData.message);
    return responseVO;
  }
}
