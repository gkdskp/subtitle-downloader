import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:subtitle_downloader/blocs/alert_bloc.dart';

enum SelectFileEvent {
  select,
  remove
}
class SelectFileBloc extends Bloc<SelectFileEvent, File> {
  final Function _errorHandler;

  SelectFileBloc(this._errorHandler);

  @override
  File get initialState => File('');

  @override
  Stream<File> mapEventToState(SelectFileEvent event) async* {
    switch(event) {
      case SelectFileEvent.select:
        File file = await FilePicker.getFile(type: FileType.video);
        if(file == null)
          yield File('');
        else
          yield file;
        break;

      case SelectFileEvent.remove:
        yield File('');
        break;

      default:
        _errorHandler(NewAlert('Unknown error occured'));
    }
  }
}