import 'package:flutter/material.dart';

class RouteNames {
  RouteNames._();

  static const initialRoute = '/';
  static const splash = '/splashScreen';
  // static const home = '/homeScreen';
  static const searchPrinters = '/search-printers';
}

class Apis {
  Apis._();

  static const baseUrl = "";
}

class MyTheme {
  MyTheme._();

  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: Colors.white,
      accentColor: Colors.indigo,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.cyanAccent,
          )));

  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    accentColor: Colors.grey,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.deepOrange,
        )),
  );
}


class MyColors {
  static const Color myCustomBlack = const Color(0x8A000000);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color warm_grey= const Color(0xff848484);
  static const Color dodger_blue= const Color(0xff4e92ff);
  static const Color black= const Color(0xff333333);
  static const Color black_two= const Color(0xff383838);
  static const Color black_four= const Color(0x7a000000);
  static const Color white_two= const Color(0xfff4f4f4);
  static const Color orangeish= const Color(0xfffa862e);
  static const Color lightish_blue= const Color(0xff407eff);
  static const Color white_three= const Color(0xffe8e8e8);
  static const Color brownish_grey= const Color(0xff6a6767);
  static const Color warm_grey_two= const Color(0xff7d7a7a);
  static const Color grapefruit= const Color(0xffff4e4e);
  static const Color very_light_pink= const Color(0xfffde9e9);
  static const Color coral= const Color(0xfff74e4e);
  static const Color white_four= const Color(0xffdbdbdb);
  static const Color black_three= const Color(0xff000000);
  static const Color warm_grey_three= const Color(0xff868686);
  static const Color white_five= const Color(0xfff0f0f0);
  static const Color white_six= const Color(0xffefefef);
  static const Color white_seven= const Color(0xffd8d8d8);
  static const Color very_light_blue= const Color(0xffdbe9ff);
  static const Color warm_grey_four= const Color(0xff7b7b7b);
  static const Color very_light_blue_two= const Color(0xffe3eeff);
  static const Color mango= const Color(0xffff862e);
  static const Color topaz= const Color(0xff18bc9c);
  static const Color greyish= const Color(0xffb1b1b1);
  static const Color vermillion= const Color(0xfff63108);
  static const Color greyish_two= const Color(0xffb4b4b4);
  static const Color white_eight= const Color(0xfff5f5f5);
  static const Color brownish_grey_two= const Color(0xff6a6a6a);
  static const Color pinkish_grey= const Color(0xffbcbcbc);
  static const Color light_pink= const Color(0xfffff0f1);
  static const Color warm_grey_five= const Color(0xff9f9f9f);
  static const Color white_nine= const Color(0xffededed);
  static const Color white_ten= const Color(0xffe5e5e5);
  static const Color white_eleven= const Color(0xfff1f1f1);
  static const Color off_white= const Color(0xfffff5e2);
  static const Color mud_brown= const Color(0xff654a15);
  static const Color white_thirteen= const Color(0xffe3e3e3);
  static const Color white_twelve= const Color(0xffdddddd);
}
