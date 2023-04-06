import 'package:e_caleg/constants/apps_theme.dart';
import 'package:e_caleg/screens/new/home_screen.dart';
import 'package:flutter/material.dart';

import '../../logic/login_logic.dart';
import '../../service/navigation_service.dart';
import '../../widgets/apps_gradient_button.dart';
import '../../widgets/apps_input.dart';

class LoginScreen extends StatelessWidget {
  static const ID = 'LoginScreen';

  LoginScreen({super.key});
  final LoginLogic logic = LoginLogic();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: gradientBackground),
          child: _displayBody(context),
        ),
      ),
    );
  }

  Widget _displayBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Image.asset(
              'assets/images/icons/logo_perindo.png',
              fit: BoxFit.fitWidth,
              height: 120,
            ),
          ),
          const SizedBox(
            height: marginMedium,
          ),
          AppsInput(inputVO: logic.inputPhoneNo),
          AppsInput(inputVO: logic.inputPassword),
          AppsGradientButton(
            label: 'LOGIN',
            height: 42,
            radius: 5.0,
            boxColor: gradientBtn,
            onPressed: () {
              NavigationService.get().push(HomeScreen());
            },
          ),
        ],
      ),
    );
  }
}
