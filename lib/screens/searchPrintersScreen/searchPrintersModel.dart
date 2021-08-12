import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

mixin SearchPrintersModel on ChangeNotifier {
  String _test = "TEST";

  String get test => _test;

  void setTest(String t) {
    _test = t;
    notifyListeners();
  }

  ButtonState _loadingStateButton = ButtonState.idle;

  ButtonState get loadingStateButton => _loadingStateButton;

  void setLoadingStateButton(ButtonState state) {
    _loadingStateButton = state;
  }
}
