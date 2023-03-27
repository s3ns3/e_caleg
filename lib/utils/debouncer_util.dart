
import 'dart:async';

class DebouncerUtil {
  final Duration delay;
  Timer? _timer;

  DebouncerUtil({this.delay = const Duration(milliseconds: 300)});

  void call(Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }

}