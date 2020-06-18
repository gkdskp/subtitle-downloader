import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/alert_bloc.dart';
import '../blocs/subtitles_list.dart';
import '../components/subtitle_tile.dart';

class SubtitlesPage extends StatefulWidget {
  final File _movieFile;
  final String _title;

  SubtitlesPage(this._movieFile, this._title);

  @override
  _SubtitlesPageState createState() => _SubtitlesPageState();
}

class _SubtitlesPageState extends State<SubtitlesPage> {
  void initState() {
    super.initState();

    BlocProvider.of<SubtitlesListBloc>(context)
        .add(SubtitlesFetch(widget._movieFile, widget._title));
    BlocProvider.of<AlertBloc>(context).add(LoadingStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtitlesListBloc, Map<String, dynamic>>(
      builder: (context, result) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Select subtitle'),
          ),
          body: BlocListener<SubtitlesListBloc, Map<String, dynamic>>(
            listener: (context, list) {
              if(result['loadEnd'])
                BlocProvider.of<AlertBloc>(context).add(ResetAlert());
                Navigator.pop(context);
            },
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return SubtitleTile(result['list'][index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: result['list'].length,
            ),
          ),
        );
      },
    );
  }
}
