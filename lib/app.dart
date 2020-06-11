import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/select_file.dart';
import 'pages/home.dart';
import './utils/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<SelectFileBloc>(
        create: (context) => SelectFileBloc(),
        child: Theme(
          data: mainTheme,
          child: HomePage(),
        ),
      ),
    );
  }
}
