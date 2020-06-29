import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/alert_bloc.dart';
import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/utils/mxintent.dart';
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
            listener: (context, result) {
              if(result['loadEnd'])BlocProvider.of<AlertBloc>(context).add(LoadingEnd());
              else if (result['loadEnd'] && result['list'].length == 0) {
                BlocProvider.of<AlertBloc>(context)
                    .add(NewAlert('No subtitles found'));
              } else if (result['loadError']) {
                BlocProvider.of<AlertBloc>(context)
                    .add(NewAlert('Couldnt contact Opensubtitles.org'));
              }
            },
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return SubtitleTile(result['list'][index], _downloadSub);
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

  void _downloadSub(Subtitle subtitle) {
    BlocProvider.of<SubtitlesListBloc>(context)
        .add(SubtitleDownload(subtitle, widget._movieFile, openWithMx));
  }

  void openWithMx() {
    print('zdvsddfsdHi');
    openMXPlayer(widget._movieFile, '');
  }
}
