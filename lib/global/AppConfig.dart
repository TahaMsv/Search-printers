import 'package:flutter/material.dart';

enum Flavor { Flavor1, Flavor2 }

extension FlavorExtension on Flavor {
  String get name {
    switch (this) {
      case Flavor.Flavor1:
        return "F1";
      case Flavor.Flavor2:
        return "F2";
      default:
        return "App";
    }
  }
}

class AppConfig {
  final Flavor? flavor;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;
  final String? baseUrl;
  static AppConfig? _instance;

  factory AppConfig({required Flavor flavor, ThemeData? lightTheme, ThemeData? darkTheme, required String baseUrl}) {
    _instance ??= AppConfig._internal(
        flavor: flavor, lightTheme: lightTheme ?? ThemeData.light(), darkTheme: darkTheme ?? ThemeData.dark(), baseUrl: baseUrl);
    return _instance!;
  }

  AppConfig._internal({this.flavor, this.lightTheme, this.darkTheme, this.baseUrl});

  static AppConfig? get instance => _instance;
  static ThemeData? get themeLight => _instance!.lightTheme;
  static ThemeData? get themeDark => _instance!.darkTheme;
  static String? get baseURL => _instance!.baseUrl;

  static bool isFlavor1() => _instance!.flavor == Flavor.Flavor1;
}
