import 'package:e_caleg/logic/login_logic.dart';
import 'package:e_caleg/screens/home_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_button.dart';
import 'package:e_caleg/widgets/apps_error_dialog.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:e_caleg/widgets/apps_input.dart';
import 'package:e_caleg/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatelessWidget {
  static const ID = 'LoginScreen';

  LoginScreen({super.key});
  final LoginLogic logic = LoginLogic();
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      futureLogic: logic.initLogic,
      child: Scaffold(body: _displayContent(context))
    );
  }

  Widget _displayContent(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/background_primary.png"),
                fit: BoxFit.cover)),
        child: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.asset(
                  'assets/images/icons/logo_perindo.png',
                  fit: BoxFit.fitWidth,
                  height: 120,
                ),
              ),
              Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      AppsInput(inputVO: logic.inputPhoneNo),
                      AppsInput(inputVO: logic.inputPassword),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {},
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Container(
                          // color: Colors.red,
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: AppsGradientButton(
                                    label: 'LOGIN',
                                    height: 42,
                                    radius: 5.0,
                                    boxColor: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF1FB2FF),
                                          Color(0xFF1FB2FF),
                                        ],
                                        tileMode: TileMode.clamp),
                                    onPressed: () {
                                      NavigationService.get()
                                          .pushReplacement(HomeScreen());
                                    },
                                  )),
                              InkWell(
                                  onTap: () async{
                                      final localAuth = LocalAuthentication();
                                      try {
                                        bool auth = await localAuth.authenticate(
                                            localizedReason: 'Pindai sidik jari anda');
                                        if (auth) {
                                          NavigationService.get().pushAndRemoveAll(HomeScreen());
                                        }
                                      } catch (e) {
                                        showAppsErrorDialog(context, e.toString());
                                      }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade50)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: const Icon(
                                          Icons.fingerprint,
                                          color: Colors.orange,
                                        )),
                                  ))
                            ],
                          )
                        ],
                      )),
                    ],
                  )),
              Spacer()
            ],
          ),
        )));
  }
}
