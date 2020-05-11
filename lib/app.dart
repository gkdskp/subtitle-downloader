import 'package:flutter/material.dart';

import 'pages/home.dart';
import './utils/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: mainTheme,
        child: HomePage(),
      ),
    );
  }
}
