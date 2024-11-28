import 'dart:async';

import 'package:flutter/foundation.dart';

class OTPTimeProvider extends ChangeNotifier {
  int _remainingTime = 60;
  Timer? timer;

  int get remainingTime => _remainingTime;

  void startTimer() {
    timer?.cancel();
    _remainingTime = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
