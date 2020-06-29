import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/theme.dart';
import './app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor,
  ));
  runApp(App());
}
