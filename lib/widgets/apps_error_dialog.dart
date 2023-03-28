import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showAppsErrorDialog(BuildContext context, String errMsg) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 20,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.all(10),
                        // color: Colors.green,
                        alignment: Alignment.center,
                        child: Text(errMsg,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: kFontSizeLarge))),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 20.0),
                      child: AppsGradientButton(
                          label: 'OK',
                          onPressed: () async {
                            NavigationService.get().pop();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
// return showCupertinoDialog(
//   context: context,
//   barrierDismissible: false,
//   builder: (BuildContext context) => CupertinoAlertDialog(
//     content: Text(errMsg,
//         textAlign: TextAlign.start,
//         style: CommonUtil.fontStyle(fontSize: fieldFontMedium)),
//     actions: <Widget>[
//       Container(
//           decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(width: 0.5, color: Colors.black12),
//               )),
//           child: CupertinoDialogAction(
//             child: Text(AppsLang.get().close),
//             onPressed: () async {
//               Navigator.pop(context);
//             },
//           ))
//     ],
//   ),
// );
// }
