import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/alert_bloc.dart';
import 'blocs/select_file.dart';
import 'pages/home.dart';
import './utils/theme.dart';
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
        theme: mainTheme(context),
        home: BlocListener<AlertBloc, Map<String, dynamic>>(
          listener: (context, error) {
            if (error['hasAlert']) {
              showMyDialog(context, error['alertType'], error['alertMsg']);
              BlocProvider.of<AlertBloc>(context).add(ResetAlert());
            }
          },
          child: HomePage(),
        ),
      ),
    );
  }
}
