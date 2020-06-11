import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:subtitle_downloader/blocs/select_file.dart';

class BrowseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SelectFileBloc _selectFileBloc = context.bloc<SelectFileBloc>();

    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            'Select File',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Browse'),
            onPressed: () => _selectFileBloc.add(SelectFileEvent.select),
            color: Theme.of(context).accentColor,
          ),
          BlocBuilder<SelectFileBloc, File>(
            builder: (context, file) {
              return Text(
                (file != null)
                    ? basename(file.path)
                    : 'No files selected',
                style: Theme.of(context).textTheme.bodyText2,
              );
            }
          ),
        ],
      ),
    );
  }
}
