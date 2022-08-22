// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Constants.dart';
import 'Pages/flash.dart';

void main(List<String> args) {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => FlashScreen(),
    },
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Constants.primary,
          statusBarIconBrightness: Brightness.light),
    )),
  ));
}
