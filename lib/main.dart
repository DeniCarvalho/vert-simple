import 'dart:io';
import 'package:intl/intl.dart';
import 'package:vert_simple/core/app_main.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  Paint.enableDithering = true;
  Intl.defaultLocale = Platform.localeName;
  await runBaseApp();
}
