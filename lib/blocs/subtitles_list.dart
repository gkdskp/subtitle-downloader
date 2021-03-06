import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/services/opensub.dart';
import 'package:subtitle_downloader/utils/downloader.dart';

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

  SubtitleDownload(this.subtitle, this.movieFile);
}

class SubtitlesListBloc extends Bloc<SubtitlesListEvent, Map<String, dynamic>> {
  SubtitlesListBloc();

  @override
  Map<String, dynamic> get initialState => {'loadEnd': false, 'list': []};

  @override
  Stream<Map<String, dynamic>> mapEventToState(
      SubtitlesListEvent event) async* {
    if (event is SubtitlesFetch) {
      try {
        yield {
          'loadError': false,
          'list': await OpenSubtitlesService.fetch(event.file, event.title),
        };
      } catch (_) {
        yield {
          'loadError': true,
          'list': [],
        };
      }
    } else if (event is SubtitleDownload) {
      try {
        await downloadSub(movieFile: event.movieFile, subtitle: event.subtitle);
        yield {
          'loadError': false,
          'list': state['list'],
          'downloaded': event.subtitle
        };
      } catch (_) {
        yield {
          'loadError': true,
          'list': state['list'],
        };
      }
    }
  }
}
