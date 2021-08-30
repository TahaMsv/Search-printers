import 'package:flutter/material.dart';

enum Flavor { DEV, QA, PRODUCTION }

extension FlavorExtension on Flavor {
  String get name {
    switch (this) {
      case Flavor.DEV:
        return "DEV";
      case Flavor.QA:
        return "QA";
      case Flavor.PRODUCTION:
        return "PRODUCTION";
      default:
        return "DEV";
    }
  }
}

class AppConfig {
  final Flavor? flavor;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;
  final String? baseUrl;
  static AppConfig? _instance;

  factory AppConfig(
      {required Flavor flavor,
      ThemeData? lightTheme,
      ThemeData? darkTheme,
      required String baseUrl}) {
    _instance ??= AppConfig._internal(
        flavor: flavor,
        lightTheme: lightTheme ?? ThemeData.light(),
        darkTheme: darkTheme ?? ThemeData.dark(),
        baseUrl: baseUrl);
    return _instance!;
  }

  AppConfig._internal(
      {this.flavor, this.lightTheme, this.darkTheme, this.baseUrl});

  static AppConfig? get instance => _instance;

  static ThemeData? get themeLight => _instance!.lightTheme;

  static ThemeData? get themeDark => _instance!.darkTheme;

  static String? get baseURL => _instance!.baseUrl;

  static bool isFlavorDEV() => _instance!.flavor == Flavor.DEV;

  static bool isFlavorQA() => _instance!.flavor == Flavor.QA;

  static bool isFlavorPRODUCTION() => _instance!.flavor == Flavor.PRODUCTION;
}
