import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

enum SelectFileEvent { select, remove }

class SelectFileBloc extends Bloc<SelectFileEvent, File> {
  SelectFileBloc();

  @override
  File get initialState => File('');

  @override
  Stream<File> mapEventToState(SelectFileEvent event) async* {
    switch (event) {
      case SelectFileEvent.select:
        File file = await FilePicker.getFile(type: FileType.video);
        if (file == null)
          yield File('');
        else
          yield file;
        break;

      case SelectFileEvent.remove:
        yield File('');
        break;

      default:
        print('Some error occured');
    }
  }
}
