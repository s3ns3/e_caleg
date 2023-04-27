import 'dart:convert';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/setting_service.dart';
import 'package:e_caleg/utils/apps_network_http.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/document_vo.dart';
import 'package:e_caleg/vo/http_response_data.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:flutter/cupertino.dart';

class UploadDocumentService {
  static const tag = 'UploadDocumentService';

  static final UploadDocumentService _instance = UploadDocumentService._();
  static UploadDocumentService get() => _instance;

  List<DocumentVO> _documentVO = [];
  List<DocumentVO> get documentVO => _documentVO;

  UploadDocumentService._();

  Future<ServiceResponseVO> requestInit() async {
    Map<String, String> headers =
        await SettingService.get().createHttpHeaders();
    Map<String, String> reqVO = {
      'tpsId': '1',
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
      List<DocumentVO> list = <DocumentVO>[];
      httpResponseData.data.forEach((v) {
        list.add(DocumentVO.fromJson(v));
      });
      _documentVO = list;
    }

    debugPrint('[$tag] --> _documentVO $_documentVO');

    ServiceResponseVO responseVO =
        ServiceResponseVO(httpResponseData.rc, httpResponseData.message);
    return responseVO;
  }
}
