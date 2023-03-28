import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/logic/login_logic.dart';
import 'package:e_caleg/screens/onboarding/login_finger_subscreen.dart';
import 'package:e_caleg/screens/registration_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:flutter/material.dart';

class CreatePassSubScreen extends BaseRegSubScreen {
  static const id = 'RegPreparationSubscreen';

  CreatePassSubScreen({Key? key})
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
    return kPageDataCreatePass;
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
          AppsInput(inputVO: logic.inputNewPassword),
          AppsInput(inputVO: logic.inputConfirmPassword),
          SizedBox(height: 10.0),
          AppsGradientButton(
              label: 'SAVE',
              onPressed: () async {
                NavigationService.get().push(LoginFingerSubScreen());
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
              Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/icons/ob_create_password.png',
                  width: 69,
                ),
              ),
              Text('Buat\nPassword',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue)),
              SizedBox(height: 8.0),
              Text('Password min 7 karakter yang terdiri dari huruf besar, huruf kecil, angka dan/atau simbol',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSizeMedium, color: Colors.grey)),
              SizedBox(height: 8.0),
              _displayContent(context),
            ],
          )
        ]));
  }
}
