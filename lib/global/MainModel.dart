import 'package:first_project/screens/searchPrintersScreen/searchPrintersModel.dart';
import 'package:flutter/material.dart';

class MainModel with ChangeNotifier, SearchPrintersModel {
  bool _loading = true;

  bool get loading => _loading;

  void setLoading(bool newLoading) {
    _loading = newLoading;
    notifyListeners();
  }
}
