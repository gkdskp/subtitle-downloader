import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/components/alert_dialog.dart';
import 'package:subtitle_downloader/components/subtitle_tile.dart';
import 'package:subtitle_downloader/blocs/subtitles_list.dart';
import 'package:subtitle_downloader/blocs/alert.dart';
import 'package:subtitle_downloader/utils/mxintent.dart';

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

    BlocProvider.of<AlertBloc>(context)
        .add(ShowAlertEvent(AlertBox.loadingMessage()));
    BlocProvider.of<SubtitlesListBloc>(context)
        .add(SubtitlesFetch(widget._movieFile, widget._title));
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
              BlocProvider.of<AlertBloc>(context).add(HideAlertEvent());
              if (result['downloaded'] != null) {
                _handleDownloaded();
              } else if (result['loadError']) {
                _handleError();
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

  void _handleError() {
    BlocProvider.of<AlertBloc>(context).add(
      ShowAlertEvent(
        AlertBox.actionsMessage(
          'No Results',
          'Try checking your internet connection or adding/editing your search term',
          [
            FlatButton(
              onPressed: () => BlocProvider.of<AlertBloc>(context).add(
                HideAlertEvent(),
              ),
              child: Text('OK'),
            )
          ],
        ),
      ),
    );
  }

  void _downloadSub(Subtitle subtitle) {
    BlocProvider.of<AlertBloc>(context)
        .add(ShowAlertEvent(AlertBox.loadingMessage()));

    try {
      BlocProvider.of<SubtitlesListBloc>(context)
          .add(SubtitleDownload(subtitle, widget._movieFile));
    } catch (_) {
      BlocProvider.of<AlertBloc>(context).add(HideAlertEvent());

      // Error handling
      BlocProvider.of<AlertBloc>(context).add(
        ShowAlertEvent(
          AlertBox.actionsMessage(
            'Cannot download',
            'Somw error occured',
            [
              FlatButton(
                onPressed: () => BlocProvider.of<AlertBloc>(context).add(
                  HideAlertEvent(),
                ),
                child: Text('OK'),
              )
            ],
          ),
        ),
      );
    }
  }

  void _handleDownloaded() async {
    BlocProvider.of<AlertBloc>(context).add(
      ShowAlertEvent(
        AlertBox.actionsMessage(
          'Downloaded',
          'Open the file in a media player to play',
          [
            FlatButton(
              onPressed: () => BlocProvider.of<AlertBloc>(context).add(
                HideAlertEvent(),
              ),
              child: Text('Dismiss'),
            ),
           // if (await getMXVersion() != null)
              FlatButton(
                child: Text('Open in MX Player'),
                onPressed: () => openMXPlayer(widget._movieFile),
              )
          ],
        ),
      ),
    );
  }
}
