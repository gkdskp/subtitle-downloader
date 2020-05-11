import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class BrowseForm extends StatelessWidget {
  final Function _handleClick;
  final File _selectedFile;

  BrowseForm(this._selectedFile, this._handleClick);

  @override
  Widget build(BuildContext context) {
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
            onPressed: _handleClick,
            color: Theme.of(context).accentColor,
          ),
          Text(
            (_selectedFile != null)
                ? basename(_selectedFile.path)
                : 'No files selected',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
