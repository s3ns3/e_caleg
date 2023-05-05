import 'dart:convert';

import 'package:e_caleg/service/apps_service.dart';
import 'package:flutter/cupertino.dart';

class SettingService {
  static const ID = 'SettingService';

  static final SettingService _instance = SettingService._();
  static SettingService get() => _instance;

  int _deviceType = 0; // default
  int get deviceType => _deviceType;

  SettingService._();

  void setDeviceType(int deviceType) {
    if (_deviceType > 0) return; // can only be set once, in splashScreen
    _deviceType = deviceType;
  }

  Future<Map<String, String>> createHttpHeaders(
      {bool useKey = true}) async {
    List<String> userSec = AppsService.get().userSec;
    Map<String, String> headers = {};
    String token = '';
    debugPrint("userSec :${userSec.toString()}");
    if(userSec.isNotEmpty) token = '${userSec[1]}:${userSec[0]}';
    String encodedToken = base64.encode(utf8.encode(token));
    headers['Authorization'] = 'Basic $encodedToken';
    headers['x-timestamp'] = '${DateTime.now().millisecondsSinceEpoch}';

    return headers;
  }

}
