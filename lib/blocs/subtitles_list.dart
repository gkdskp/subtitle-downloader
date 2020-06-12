import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/services/opensub.dart';

enum SubtitlesListEvent {
  fetch
}

class SubtitlesListBloc extends Bloc<SubtitlesListEvent, List<Subtitle>> {
  @override
  List<Subtitle> get initialState => [];

  @override
  Stream<List<Subtitle>> mapEventToState(SubtitlesListEvent event) async* {
    switch(event) {
      case SubtitlesListEvent.fetch:
        yield await OpenSubtitlesService.fetch(File(''));
        break;
      
      default:
        throw new Exception('Unknown event');
    }
  }
}