import 'package:e_caleg/utils/apps_rc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBlocState {
  final String rc;
  final String message;
  final int progress; // 0 - 100

  double get progressDouble => progress / 100;

  SplashBlocState(this.rc, this.message, this.progress);

  SplashBlocState.init(): this(rcInProgress, '', 0);

  @override
  String toString() {
    return 'SplashBlocState{rc: $rc, message: $message'
        ', progress: $progress}';
  }
}

class SplashBloc extends Bloc<bool, SplashBlocState> {
  static const ID = 'SplashBloc';

  SplashBloc() : super(SplashBlocState.init());

  @override
  Stream<SplashBlocState> mapEventToState(bool event) async* {
    // if error cannot be recovered, set progress 100
    try {
      if (state.progress == 0) {
        await Future.delayed(const Duration(milliseconds: 200), () sync*{
          yield SplashBlocState(rcInProgress, '', 15);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 20);
      }
      // check jailbreak
      if (state.progress == 10) {
        await Future.delayed(const Duration(milliseconds: 200), () sync*{
          yield SplashBlocState(rcInProgress, '', 15);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 20);
      }
      // init database
      if (state.progress == 20) {
        await Future.delayed(const Duration(milliseconds: 300), () sync*{
          yield SplashBlocState(rcInProgress, '', 25);
          return;
        });

        yield SplashBlocState(rcInProgress, '', 30);
      }
      // check data
      if (state.progress == 30) {
        await Future.delayed(const Duration(milliseconds: 400), () sync*{
          yield SplashBlocState(rcInProgress, '', 30);
          return;
        });

        yield SplashBlocState(rcInProgress, '', 35);
      }
      if (state.progress == 35) {
        await Future.delayed(const Duration(milliseconds: 300), () sync*{
          yield SplashBlocState(rcInProgress, '', 35);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 40);
      }

      // get firebase token
      if (state.progress == 40) {
        await Future.delayed(const Duration(milliseconds: 200), () sync*{
          yield SplashBlocState(rcInProgress, '', 45);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 50);
      }

      // sync model
      if (state.progress == 50) {
        await Future.delayed(const Duration(milliseconds: 200), () sync*{
          yield SplashBlocState(rcInProgress, '', 55);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 60);
      }

      // fetch image for menu category icon
      if (state.progress == 60) {
        await Future.delayed(const Duration(milliseconds:400), () sync*{
          yield SplashBlocState(rcInProgress, '', 60);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 65);
      }
      if (state.progress == 65) {
        await Future.delayed(const Duration(milliseconds: 300), () sync*{
          yield SplashBlocState(rcInProgress, '', 70);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 80);
      }

      // check if need check status
      if (state.progress == 80) {
        await Future.delayed(const Duration(milliseconds: 200), () sync*{
          yield SplashBlocState(rcInProgress, '', 85);
          return;
        });
        yield SplashBlocState(rcInProgress, '', 90);
      }

      // done
      if (state.progress == 90) {
        await Future.delayed(const Duration(milliseconds: 100), () sync*{
          yield SplashBlocState(rcInProgress, '', 95);
          return;
        });
        yield SplashBlocState(rcSuccess, '', 100);
      }
    } catch (e) {
      debugPrint('Error $e');
//      String msg = 'System error: $e';
//      if (msg.length > 200) msg = msg.substring(0, 200) + '..';
      String msg = 'Error system';
      yield SplashBlocState(rcSystemError, msg, 100);
    }
  }
}