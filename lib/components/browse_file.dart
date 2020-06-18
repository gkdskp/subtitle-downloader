import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
            RaisedButton(
              child: Text('Browse', style: Theme.of(context).textTheme.button,),
              onPressed: () => BlocProvider.of<SelectFileBloc>(context)
                  .add(SelectFileEvent.select),
              color: Theme.of(context).accentColor,
            ),
            SizedBox(height: 5),
            BlocBuilder<SelectFileBloc, File>(builder: (context, file) {
              return Text(
                basename(file.path),
                style: Theme.of(context).textTheme.bodyText2,
              );
            }),
          ],
        ),
      ),
    ); 
  }
}
