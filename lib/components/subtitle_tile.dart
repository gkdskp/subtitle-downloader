import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/blocs/alert_bloc.dart';

import '../models/subtitles.dart';

class SubtitleTile extends StatelessWidget {
  final Subtitle _subtitle;

  SubtitleTile(this._subtitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_subtitle.fileName),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_subtitle.subRating} (${_subtitle.noOfVotes} votes)'),
          if(_subtitle.fileMatch)
              Text('File Match', style: TextStyle(color: Colors.greenAccent))
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.arrow_downward),
        onPressed: () {
          BlocProvider.of<AlertBloc>(context).add(NewAlert('Cannot download'));
        },
      ),
    );
  }
}
