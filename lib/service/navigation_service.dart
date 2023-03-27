
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  static const ID = 'NavigationService';

  static NavigationService _instance = NavigationService._();
  static NavigationService get() => _instance;

  NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(Widget screenWidget) {
    debugPrint('[$ID] push: ${screenWidget.runtimeType.toString()}');
    return navigatorKey.currentState!.push(
        PageTransition(type: PageTransitionType.rightToLeft, child: screenWidget));
  }

  Future<dynamic> pushReplacement(Widget screenWidget) {
    debugPrint('[$ID] pushReplacement: ${screenWidget.runtimeType.toString()}');
    return navigatorKey.currentState!.pushReplacement(
        PageTransition(type: PageTransitionType.fade, child: screenWidget));
  }

  // Future<dynamic> pushAndRemoveUntil(Widget screenWidget, RoutePredicate predicate) {
  //   debugPrint('[$ID] pushAndRemoveUntil: ${screenWidget.runtimeType.toString()}');
  //   return navigatorKey.currentState!.pushAndRemoveUntil(
  //       PageTransition(type: PageTransitionType.fade, child: screenWidget), predicate);
  // }
  Future<dynamic> pushAndRemoveAll(Widget screenWidget) {
    debugPrint('[$ID] pushAndRemoveAll: ${screenWidget.runtimeType.toString()}');
    return navigatorKey.currentState!.pushAndRemoveUntil(
        PageTransition(type: PageTransitionType.fade, child: screenWidget),
            (Route<dynamic> route) => false
    );
  }
  Future<dynamic> pushAndRemoveUntilHome(Widget screenWidget) {
    debugPrint('[$ID] pushAndRemoveUntilHome: ${screenWidget.runtimeType.toString()}');
    return navigatorKey.currentState!.pushAndRemoveUntil(
        PageTransition(type: PageTransitionType.fade, child: screenWidget),
            (Route<dynamic> route) {
              if (route.isFirst) return true;
              else return false;
            }
    );
  }


  dynamic pop<T extends Object>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }
  void popUntilHome() {
    debugPrint('[$ID] popUntilHome');
    return navigatorKey.currentState!.popUntil((Route<dynamic> route) {
          if (route.isFirst) return true;
          else return false;
        }
    );
  }
}