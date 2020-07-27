import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/blocs/select_file.dart';

class SearchForm extends StatefulWidget {
  final Function _handleSubmit;

  SearchForm(this._handleSubmit);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _titleController = TextEditingController();
  var _hasSearchTerm = false;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter your own search term'),
                Checkbox(
                  value: _hasSearchTerm,
                  onChanged: (value) => _setVisible(value),
                ),
              ],
            ),
            if (_hasSearchTerm)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Example: Breaking Bad S01E01',
                ),
                controller: _titleController,
              ),
            SizedBox(height: 30),
            BlocBuilder<SelectFileBloc, File>(builder: (context, file) {
              return RaisedButton.icon(
                icon: Icon(Icons.check),
                label: Text('Search for subtitles'),
                onPressed: () =>
                    widget._handleSubmit(file, _titleController.text),
                color: Theme.of(context).accentColor,
              );
            }),
          ],
        ),
      ),
    );
  }

  void _setVisible(bool val) {
    setState(() {
      _hasSearchTerm = val;
    });
  }
}
