import 'screens/searchPrintersScreen/searchPrintersView.dart';
import 'package:flutter/material.dart';

import '../utility/Constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'global/MainModel.dart';
import 'global/AppConfig.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainModel _model = context.watch<MainModel>();
    return GetMaterialApp(
      enableLog: false,
      debugShowCheckedModeBanner: false,
      theme: AppConfig.themeLight,
      initialRoute: RouteNames.searchPrinters,
      getPages: [
        // GetPage(name: RouteNames.splash , page:()=> SplashView(_model)),
        // GetPage(name: RouteNames.home , page:()=> HomeView(_model)),
        GetPage(name: RouteNames.searchPrinters , page:()=> SearchPrintersView(_model)),
      ],
    );
  }
}
