import 'package:flutter/material.dart';

import '../data/subtitles.dart';

class SubtitleTile extends StatelessWidget {
  final Subtitle _subtitle;
  final Function _handleClick;

  SubtitleTile(this._subtitle, this._handleClick);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_subtitle.fileName),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_subtitle.subRating} (${_subtitle.noOfVotes} votes)'),
          (_subtitle.fileMatch)
              ? Text('File Match', style: TextStyle(color: Colors.greenAccent))
              : Container(width: 0, height: 0),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.arrow_downward),
        onPressed: () => _handleClick(_subtitle),
      ),
    );
  }
}
