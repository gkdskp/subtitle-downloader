import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/blocs/select_file.dart';

class BrowseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              'Select File',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 15),
            BlocBuilder<SelectFileBloc, File>(builder: (context, file) {
              return (file.path == '')
                  ? RaisedButton.icon(
                      icon: Icon(Icons.video_library),
                      label: Text(
                        'Browse',
                      ),
                      onPressed: () => BlocProvider.of<SelectFileBloc>(context)
                          .add(SelectFileEvent.select),
                      color: Theme.of(context).accentColor,
                    )
                  : Column(
                      children: [
                        RaisedButton.icon(
                          icon: Icon(Icons.cancel),
                          label: Text(
                            'Remove',
                          ),
                          onPressed: () =>
                              BlocProvider.of<SelectFileBloc>(context)
                                  .add(SelectFileEvent.remove),
                          color: Colors.red,
                        ),
                        SizedBox(height: 5),
                        Text(
                          basename(file.path),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    );
            }),
          ],
        ),
      ),
    );
  }
}
