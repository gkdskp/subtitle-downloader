import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/subtitles_list.dart';

class SearchForm extends StatefulWidget {

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _titleController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Optional',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text('Search for subtitles'),
              onPressed: () {
                BlocProvider.of<SubtitlesListBloc>(context)
                    .add(SubtitlesListEvent.fetch);
              },
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
