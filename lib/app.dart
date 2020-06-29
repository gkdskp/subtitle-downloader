import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/alert_bloc.dart';
import 'blocs/select_file.dart';
import 'pages/home.dart';
import './components/theme.dart';
import './components/alert_dialog.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlertBloc>(
          create: (context) => AlertBloc(),
        ),
        BlocProvider<SelectFileBloc>(
          create: (context) => SelectFileBloc(BlocProvider.of<AlertBloc>(context).add),
        ),
      ],
      child: MaterialApp(
        theme: mainTheme,
        home: BlocListener<AlertBloc, Map<String, dynamic>>(
          listener: (context, error) {
            if(error['hasAlert'] && error['alertType'] == DialogType.OpenWithDialog) {
              print('Action');
              print(error['actions']);
              showAlertDialog(context, error['alertType'], error['alertMsg'], actions: error['actions']);
            }
            else if(!error['hasAlert'] && error['alertType'] == DialogType.Loading) {
              Navigator.pop(context);
            }

            else if (error['hasAlert']) {
              showAlertDialog(context, error['alertType'], error['alertMsg']);
            } 
          },
          child: HomePage(),
        ),
      ),
    );
  }
}
