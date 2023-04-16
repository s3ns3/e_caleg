import 'dart:convert';

import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/setting_service.dart';
import 'package:e_caleg/utils/apps_network_http.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/vo/http_response_data.dart';
import 'package:e_caleg/vo/service_response_vo.dart';
import 'package:e_caleg/vo/user_data_vo.dart';
import 'package:flutter/cupertino.dart';

class LoginService {
  String tag = 'LoginService';
  static final LoginService _instance = LoginService._();
  UserDataVO _userDataVO = UserDataVO.empty();
  UserDataVO get userDataVO => _userDataVO;
  static LoginService get() => _instance;
  LoginService._();

  Future<ServiceResponseVO> sendLoginPass(String userName, String password) async {
    return _sendLogin(
        endPoint: kEndponitLoginPass, username:userName, password: password, bioToken: '');
  }

  Future<ServiceResponseVO> _sendLogin(
      {required String endPoint,
      required String username,
      required String password,
      required String bioToken}) async {
    Map<String, String> headers =
        await SettingService.get().createHttpHeaders();
    Map<String, String> reqVO = {
      'username': username,
      'password': password,
    };
    String bodyContent = jsonEncode(reqVO);

    final networkHttp = AppsNetworkHttp.get();
    HttpResponseData httpResponseData =
        await networkHttp.sendPostRequestToServer(
            endPoint: endPoint,
            headers: headers,
            bodyContent: bodyContent);
    debugPrint('[$tag] --> _sendLogin $httpResponseData');
    String? cacheId;
    if (httpResponseData.rc == rcSuccess && httpResponseData.data is Map) {
      //map data user
      UserDataVO vo = UserDataVO.fromJson(httpResponseData.data);
      _userDataVO = vo;
    }

    ServiceResponseVO responseVO = ServiceResponseVO(
        httpResponseData.rc!, httpResponseData.message!,
        data: cacheId);
    return responseVO;
  }
}