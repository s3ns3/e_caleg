import 'package:e_caleg/bloc/refresh_screen_bloc.dart';
import 'package:e_caleg/constants/apps_constant.dart';
import 'package:e_caleg/service/navigation_service.dart';
import 'package:e_caleg/utils/apps_ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseUploadScreen extends StatelessWidget {
  static const int kPageCount = kJumlahPartai;
  String getRegInfo();
  int getPageIndex();
  int setIndex();
  Widget buildSubScreen(BuildContext context, RefreshScreenCubit bloc);
  final RefreshScreenCubit bloc = RefreshScreenCubit();
  final Function() onBack;

  BaseUploadScreen({Key? key, required this.onBack}) : super(key: key);

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: BlocProvider<RefreshScreenCubit>(
                    create: (context) => bloc,
                    child: BlocBuilder<RefreshScreenCubit, bool>(
                        builder: (context, state) {
                      if (getPageIndex() == 5) {
                        _controller.animateTo(
                            MediaQuery.of(context).size.width * .8,
                            curve: Curves.ease,
                            duration: const Duration(seconds: 1));
                      }
                      return _displayContent(context);
                    })))),
        onWillPop: () {
          onBack();
          return Future.value(true);
        });
  }

  Widget _displayContent(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _displayIndicatorText(context),
          _displayIndicator(context, getPageIndex()),
          Expanded(
            child: Container(
                // height: MediaQuery.of(context).size.height - 170,
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                ),
                child: buildSubScreen(context, bloc)),
          )
        ]);
  }

  Widget _displayIndicator(BuildContext context, int index) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 200)),
                builder: (context, snapshot) {
                  // need to be rebuild again, because the indicator is not refreshed
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      child: _displayIndicatorDot(context, index));
                })
          ],
        ));
  }

  Widget _displayIndicatorDot(BuildContext context, int index) {
    List<Widget> indicator = [];
    debugPrint('loop $kPageCount');
    for (var i = 1; i <= kPageCount; i++) {
      Widget image;
      if (i < index) {
        image = const Icon(Icons.done_all, color: Colors.white, size: 20.0);
      } else if (i == index) {
        image = Text(
          i.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: kFontSizeXLarge,
              fontWeight: FontWeight.w700),
        );
      } else {
        image = Text(
          i.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: kFontSizeXLarge,
              fontWeight: FontWeight.w700),
        );
      }
      indicator.add(Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: i <= index ? kColorBlueDark : const Color(0xFFB3B3B3),
                borderRadius: BorderRadius.circular(80.0)),
            // child: image,
            child: Container(
              width: 25,
              height: 25,
              color: i <= index ? kColorBlueDark : const Color(0xFFB3B3B3),
              alignment: Alignment.center,
              child: image,
            ),
          ),
          i == kPageCount
              ? Container()
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  color: i >= index ? const Color(0xFFB3B3B3) : kColorBlueDark,
                  height: 3,
                  width: 30,
                ),
        ],
      ));
    }
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicator,
        ));
  }

  Widget _displayIndicatorText(BuildContext context) {
    String title = getRegInfo();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 70.0,
      width: MediaQuery.of(context).size.width * .7,
      decoration: const BoxDecoration(
          gradient: kLinearGradient,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(100.0),
          )),
      child: Row(
        children: [
          InkWell(
              onTap: () => NavigationService.get().pop(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: Colors.white,
              )),
          const SizedBox(width: 5.0),
          Text(
            title,
            style: const TextStyle(
                fontSize: kFontSizeXLarge,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
