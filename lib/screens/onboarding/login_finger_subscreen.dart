import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/logic/login_logic.dart';
import 'package:e_caleg/screens/login_screen.dart';
import 'package:e_caleg/screens/registration_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_error_dialog.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginFingerSubScreen extends BaseRegSubScreen {
  static const id = 'RegPreparationSubscreen';

  LoginFingerSubScreen({Key? key})
      : super(
            key: key,
            onBack: () {
              NavigationService.get().pop();
            });

  LoginLogic logic = LoginLogic();
  @override
  String getRegInfo() {
    return '';
  }

  @override
  int getPageIndex() {
    return kPageDataLoginFinger;
  }

  @override
  Widget buildSubScreen(BuildContext context) {
    return _displayBody(context);
  }

  Widget _displayContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          AppsGradientButton(
              label: 'GUNAKAN SIDIK JARI',
              onPressed: () async {
                outBiometric(context);
              })
        ],
      ),
    );
  }

  Widget _displayBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.fingerprint,
                ),
              ),
              Text('Login Menggunakan\nSidik Jari',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue)),
              SizedBox(height: 8.0),
              Text(
                  'Lakukan autentikasi sidik jari untuk memudahkan login menggunakan sidik jari',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: fontSizeMedium, color: Colors.grey)),
              SizedBox(height: 8.0),
              _displayContent(context),
            ],
          )
        ]));
  }

  void outBiometric(BuildContext context) async {
    final localAuth = LocalAuthentication();
    try {
      bool auth = await localAuth.authenticate(
          localizedReason: 'Pindai sidik jari anda');
      if (auth) {
        NavigationService.get().pushAndRemoveAll(LoginScreen());
      }
    } catch (e) {
      showAppsErrorDialog(context, e.toString());
    }
  }
}
