import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/services/opensub.dart';
import 'package:subtitle_downloader/utils/downloader.dart';
import 'package:subtitle_downloader/utils/mxintent.dart';

import 'alert_bloc.dart';

abstract class SubtitlesListEvent {
  String title;
  File file;
}

class SubtitlesFetch extends SubtitlesListEvent {
  final String title;
  final File file;

  SubtitlesFetch(this.file, this.title);
}

class SubtitleDownload extends SubtitlesListEvent {
  final Subtitle subtitle;
  final File movieFile;
  final Function subDownload;

  SubtitleDownload(this.subtitle, this.movieFile, this.subDownload);
}

class SubtitlesListBloc extends Bloc<SubtitlesListEvent, Map<String, dynamic>> {
  final Function _handleError;

  SubtitlesListBloc(this._handleError);

  @override
  Map<String, dynamic> get initialState => {'loadEnd': false, 'list': []};

  @override
  Stream<Map<String, dynamic>> mapEventToState(
      SubtitlesListEvent event) async* {
    if (event is SubtitlesFetch) {
      try {
        yield {
          'loadEnd': true,
          'list': await OpenSubtitlesService.fetch(event.file, event.title),
          'loadError': false
        };
      } catch (_) {
        yield {
          'loadError': true,
          'loadEnd': false,
          'list': [],
        };
      }
    } else if (event is SubtitleDownload) {
      try {
        _handleError(LoadingStart());
        String subFile = await downloadSub(
            movieFile: event.movieFile, subtitle: event.subtitle);
        _handleError(LoadingEnd());
        _handleError(OpenWithAlert(event.subDownload));
      } catch (_) {
        _handleError(NewAlert(_.toString()));
      }
    }
  }
}
