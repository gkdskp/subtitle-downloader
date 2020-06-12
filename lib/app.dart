import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/subtitles_list.dart';
import 'blocs/select_file.dart';
import 'pages/home.dart';
import './utils/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SelectFileBloc>(
            create: (context) => SelectFileBloc(),
          ),
          BlocProvider<SubtitlesListBloc>(
            create: (context) => SubtitlesListBloc(),
          ),
        ],
        child: Theme(
          data: mainTheme,
          child: HomePage(),
        ),
      ),
    );
  }
}
