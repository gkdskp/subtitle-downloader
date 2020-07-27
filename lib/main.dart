import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:subtitle_downloader/components/theme.dart';
import 'package:subtitle_downloader/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor,
  ));
  runApp(App());
}
