import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/alert.dart';
import 'blocs/select_file.dart';
import 'pages/home.dart';
import './components/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SelectFileBloc>(
      create: (context) => SelectFileBloc(),
      child: BlocProvider<AlertBloc>(
        create: (context) => AlertBloc(),
        child: MaterialApp(
          theme: mainTheme,
          home: BlocListener<AlertBloc, Map<String, dynamic>>(
            listener: (context, state) {
              if (state['hasAlert'] == true) {
                _showAlert(context, state['alertBox']);
              } else {
                Navigator.pop(context);
              }
            },
            child: HomePage(),
          ),
        ),
      ),
    );
  }

  Future<void> _showAlert(BuildContext context, AlertDialog dialog) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
