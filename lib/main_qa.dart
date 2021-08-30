// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import '../../MyApp.dart';
import '../../global/MainModel.dart';
import 'package:provider/provider.dart';

import '../../global/AppConfig.dart';
import '../../utility/Constants.dart';

void main() {
  AppConfig(
      flavor: Flavor.QA,
      baseUrl: Apis.baseUrl,
      lightTheme: MyTheme.light,
      darkTheme: MyTheme.dark);

  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
          () => runApp(MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => MainModel())],
        child: MyApp(),
      )),
          (e, _) => print("root error : $e"));
}
