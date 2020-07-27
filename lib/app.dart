import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/blocs/alert.dart';
import 'package:subtitle_downloader/blocs/select_file.dart';
import 'package:subtitle_downloader/pages/home.dart';
import 'package:subtitle_downloader/components/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlertBloc>(
          create: (context) => AlertBloc(),
        ),
        BlocProvider<SelectFileBloc>(
          create: (context) => SelectFileBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
    );
  }

  Future<void> _showAlert(BuildContext context, AlertDialog dialog) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
