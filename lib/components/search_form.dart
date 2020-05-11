import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchForm extends StatefulWidget {
  final Function _handleSearch;

  SearchForm(this._handleSearch);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  var isEpisode = false;

  final _titleController = TextEditingController();
  final _seasonController = TextEditingController();
  final _episodeController = TextEditingController();

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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Movie'),
                  Switch(
                    value: isEpisode,
                    onChanged: (bool value) {
                      setState(() {
                        isEpisode = value;
                      });
                    },
                  ),
                  Text('Series episode'),
                ],
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
            ),
            (isEpisode)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.0,
                        child: TextFormField(
                          controller: _seasonController,
                          decoration: InputDecoration(
                            labelText: 'Season',
                            errorMaxLines: 5,
                          ),
                          validator: (value) {
                            if (double.tryParse(value) == null) {
                              return 'Enter season number';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                        ),
                      ),
                      Container(
                        width: 75.0,
                        child: TextFormField(
                          controller: _episodeController,
                          decoration: InputDecoration(
                            labelText: 'Episode',
                            errorMaxLines: 5,
                          ),
                          validator: (value) {
                            if (double.tryParse(value) == null) {
                              return 'Enter Episode number';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text('Search for subtitles'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  widget._handleSearch(
                    title: _titleController.text,
                    season:
                        (isEpisode) ? int.parse(_seasonController.text) : null,
                    episode:
                        (isEpisode) ? int.parse(_episodeController.text) : null,
                  );
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
