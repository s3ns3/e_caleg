import 'dart:convert';

import 'package:flutter/foundation.dart';

class SettingService {
  static const ID = 'SettingService';

  static final SettingService _instance = SettingService._();
  static SettingService get() => _instance;

  final Map<String, String> _settings = {};

  int _deviceType = 0; // default
  int get deviceType => _deviceType;

  SettingService._();

  void setDeviceType(int deviceType) {
    if (_deviceType > 0) return; // can only be set once, in splashScreen
    _deviceType = deviceType;
  }

  Future<Map<String, String>> createHttpHeaders(
      {bool useKey = true}) async {
    Map<String, String> headers = {};
    String token = 'test:123';
    String encodedToken = base64.encode(utf8.encode(token));
    headers['Authorization'] = 'Basic $encodedToken';
    headers['x-timestamp'] = '${DateTime.now().millisecondsSinceEpoch}';

    return headers;
  }

}
