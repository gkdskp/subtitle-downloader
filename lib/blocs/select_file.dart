import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

enum SelectFileEvent {
  select
}

class SelectFileBloc extends Bloc<SelectFileEvent, File> {
  @override
  File get initialState => File(null);

  @override
  Stream<File> mapEventToState(SelectFileEvent event) async* {
    switch(event) {
      case SelectFileEvent.select:
        yield await FilePicker.getFile();
        break;

      default:
        throw new Exception('Unknown event');
    }
  }
}