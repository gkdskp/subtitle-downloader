import 'package:flutter/material.dart';
import 'package:subtitle_downloader/utils/mxintent.dart';

import '../models/subtitles.dart';

class SubtitleTile extends StatelessWidget {
  final Subtitle _subtitle;
  final Function _handleDownload;

  SubtitleTile(this._subtitle, this._handleDownload);

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
          _handleDownload(_subtitle);
        },
      ),
    );
  }
}
