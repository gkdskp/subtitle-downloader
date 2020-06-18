import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/services/opensub.dart';


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
  final int index;

  SubtitleDownload(this.index);
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
        var subtitleList =
            await OpenSubtitlesService.fetch(event.file, event.title);
        if (subtitleList.length == 0)
          _handleError(NewAlert('No subtitles found'));
        yield {
          'loadEnd': true,
          'list': subtitleList,
        };
      } on FormatException catch (_) {
        yield {
          'loadEnd': true,
          'list': [],
        };
        _handleError(NewAlert(_.toString()));
      }
    } else if(event is SubtitleDownload) {
      
    }
  }
}
