import 'dart:io';

import 'package:e_caleg/bloc/splash_bloc.dart';
import 'package:e_caleg/screens/login_screen.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_rc.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SplashScreen extends StatelessWidget {
  static const ID = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false, child: Scaffold(body: _displayContent(context)));
  }

  Widget _displayContent(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: Container(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Container()),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Image.asset(
                      'assets/images/icons/logo_perindo.png',
                      fit: BoxFit.fitWidth,
                      height: 80,
                    ),
                  ),
                  // const Text("Data Initiation",
                  //   style: TextStyle(
                  //       color: Colors.white, fontSize: kFontSizeXLarge),
                  // ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  _displayProgress(context),
                  Expanded(child: Container()),
                  // Container(
                  //     margin: const EdgeInsets.symmetric(vertical: 20.0),
                  //     child: const VersionLabel(labelColor: Colors.black))
                ],
              ),
            )));
  }

  Widget _displayProgress(BuildContext context) {
    debugPrint('[$ID] _displayProgress');
    return BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(true),
        child: BlocBuilder<SplashBloc, SplashBlocState>(
          builder: (context, state) {
            debugPrint('[$ID] blocBuilder: $state');
            if (state.rc == rcSuccess) {
              // success
              Future.delayed(Duration.zero, () {
                  NavigationService.get().pushAndRemoveAll(LoginScreen());
              });
            } else if (state.rc != rcInProgress) {
              // failed
              // Future.delayed(Duration.zero, () {
              //   // showAppWarning(context,icon: "assets/images/icon/icon_error.png", title: LangUtil.get().titleError, message: "fsadfasdfasd");
              //   _processAppsError(context, state.rc, state.message)
              //       .then((closed) {
              //     if (closed ?? true) {
              //       // exit apps
              //       SystemNavigator.pop();
              //     } else {
              //       // retry
              //       BlocProvider.of<SplashBloc>(context).add(true);
              //     }
              //   });
              // });
            }
            final pct = '${state.progress}%';
            return Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: state.progress,
                  size: 15,
                  padding: 0,
                  selectedColor: Colors.yellow,
                  unselectedColor: Colors.cyan,
                  roundedEdges: const Radius.circular(10),
                  selectedGradientColor: kButtonGradient,
                  unselectedGradientColor: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kColorPrimaryLight, kColorPrimary, kColorPrimary],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(
                  pct,
                  style: const TextStyle(
                      color: Colors.white, fontSize: kFontSizeMedium),
                )
              ],
            );
          },
        ));
  }

  // return true if need close, false if need retry
  // Future<bool?> _processAppsError(
  //     BuildContext context, String rc, String message) async {
  //   debugPrint('[$ID] _processAppsError: $rc, $message');
  //   return showCupertinoModalPopup<bool>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         List<Widget> actions = [];
  //         actions.add(_displayButtonDialog(
  //             context, LangUtil.get().close, kColorButtonGold, () {
  //           // close this dialog
  //           Navigator.pop(context);
  //           if (Platform.isAndroid) {
  //             SystemNavigator.pop();
  //           } else if (Platform.isIOS) {
  //             exit(0);
  //           }
  //         }));
  //         debugPrint("$ID rc :$rc");
  //         if (rc == rcConnectionError || rc == rcNetworkGeneralError) {
  //           // display button to retry
  //           actions.add(const SizedBox(
  //             width: 20.0,
  //           ));
  //           actions.add(_displayButtonDialog(
  //               context, LangUtil.get().retry, kColorButtonGold, () {
  //             // close this dialog and request retry
  //             Navigator.pop(context, false);
  //           }));
  //         }else if (rc == rcAppsNeedUpgrade) {
  //           // display button to open play store
  //           actions.add(const SizedBox(
  //             width: 20.0,
  //           ));
  //           actions.add(_displayButtonDialog(
  //               context, LangUtil.get().update, kColorButtonGold, () {
  //             // open play store
  //             // LaunchReview.launch();
  //             // close this dialog
  //             Navigator.pop(context, true);
  //           }));
  //         }
  //
  //           return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           elevation: 20,
  //           child: IntrinsicWidth(
  //             child: IntrinsicHeight(
  //                 child: Container(
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.symmetric(horizontal: 20),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 image: const DecorationImage(
  //                   image: AssetImage(
  //                       'assets/images/background/background_popup.png'),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 20),
  //                     child: Image.asset("assets/images/icon/icon_error.png",
  //                         width: 200),
  //                   ),
  //                   Text(message,
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                           fontSize: kFontSizeXLarge,
  //                           color: Colors.grey[600]!,
  //                           fontWeight: FontWeight.w700)),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: actions,
  //                   ),
  //                   const Padding(padding: EdgeInsets.only(bottom: 5))
  //                 ],
  //               ),
  //             )),
  //           ),
  //         );
  //       });
  // } // _processAppsError

  // Widget _displayButtonDialog(BuildContext context, String label,
  //     Color activeColor, Function()? onClick) {
  //   return Container(
  //       width: MediaQuery.of(context).size.width * 0.3,
  //       decoration: const BoxDecoration(
  //           border: Border(
  //         top: BorderSide(width: 0.5, color: Colors.black12),
  //       )),
  //       child: AppsButton(
  //         activeColor: activeColor,
  //         label: label,
  //         onClick: onClick,
  //       ));
  // } // _displayButtonDialog
}
