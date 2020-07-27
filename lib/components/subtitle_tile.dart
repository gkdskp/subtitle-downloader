import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/blocs/subtitles_list.dart';

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
          if (_subtitle.fileMatch)
            Text('File Match', style: TextStyle(color: Colors.greenAccent))
        ],
      ),
      trailing: BlocBuilder<SubtitlesListBloc, Map<String, dynamic>>(
          builder: (context, snapshot) {
        return IconButton(
          icon: Icon(
            Icons.arrow_downward,
            color: (snapshot['downloaded'] != null &&
                    snapshot['downloaded'] == _subtitle)
                ? Colors.green
                : Colors.white,
          ),
          onPressed: () {
            _handleDownload(_subtitle);
          },
        );
      }),
    );
  }
}
