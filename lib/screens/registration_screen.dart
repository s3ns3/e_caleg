import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:flutter/material.dart';

abstract class BaseRegSubScreen extends StatelessWidget {
  static const int kPageCount = 3;
  String getRegInfo();
  int getPageIndex();
  Widget buildSubScreen(BuildContext context);
  final Function() onBack;

  const BaseRegSubScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white, body: _displayContent(context))),
        onWillPop: () {
          onBack();
          return Future.value(true);
        });
  }

  Widget _displayContent(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _displayIndicatorText(context),
            _displayIndicator(context, getPageIndex()),
            Expanded(
              child: Container(
                  // height: MediaQuery.of(context).size.height - 170,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  child: buildSubScreen(context)),
            )
          ]),
    );
  }

  Widget _displayIndicator(BuildContext context, int index) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 200)),
                builder: (context, snapshot) {
                  // need to be rebuild again, because the indicator is not refreshed
                  return _displayIndicatorDot(context, index);
                })
          ],
        ));
  }

  Widget _displayIndicatorDot(BuildContext context, int index) {
    debugPrint(
        '[BaseRegSubScreen] _displayIndicatorDot: ${this.runtimeType} $index');
    List<Widget> indicator = [];
    debugPrint('loop $kPageCount');
    for (var i = 0; i <= kPageCount; i++) {
      Widget image;
      if (i < index) {
        image = Image.asset('assets/images/icons/ob_step_done.png',
            width: 20.0);
      } else if (i == index) {
        image = Image.asset('assets/images/icons/ob_step_active.png',
            width: 20.0);
      } else {
        image = Image.asset('assets/images/icons/ob_step_next.png',
            width: 20.0);
      }
      indicator.add(Container(
        child: Row(
          children: [
            image,
            i == kPageCount
                ? Container()
                : Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
                    color: i >= index ? Color(0xFFB3B3B3) : Color(0xFF034EA2),
                    height: 3,
                    width: 90,
            ),
          ],
        ),
      ));
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicator,
        ));
  }

  Widget _displayIndicatorText(BuildContext context) {
    String title = getRegInfo();
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 17.5),
        child: Row(
          children: [
            InkWell(
              child: Icon(Icons.arrow_back_sharp),
              onTap: onBack, // () => NavigationService.get().pop(),
            ),
            SizedBox(width: 10.0),
            Flexible(
                child: Text(
              title,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Colors.black, fontSize: kFontSizeMedium),
            ))
          ],
        ));
  }
}
