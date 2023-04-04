import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/widgets/apps_gradient_button.dart';
import 'package:flutter/material.dart';

class DialogConfirmation extends StatelessWidget {
  static const ID = 'DialogActivation';
  final String? title;
  final Widget? message;
  final String? lblButtonLeft;
  final String? lblButtonRight;
  final Function()? onClickLeft;
  final Function()? onClickRight;

  const DialogConfirmation(
      {Key? key,
        this.title = "",
        this.message,
        this.lblButtonLeft,
        this.lblButtonRight,
        this.onClickLeft,
        this.onClickRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 8.0, right: 13.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.red,
                      ),
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        NavigationService.get().pop();
                      },
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(bottom: 10.0),
                    alignment: Alignment.center,
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(10),
                  child: message,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: 20.0),
                      child: AppsGradientButton(
                          label: lblButtonRight!.toUpperCase(),
                          onPressed: onClickRight!),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
