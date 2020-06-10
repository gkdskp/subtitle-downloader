import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/subtitle_tile.dart';
import '../models/subtitles.dart';
import '../utils/unarchive.dart';
import '../services/opensub.dart';

class SubtitlesPage extends StatefulWidget {
  final File file;
  final String imdbID;

  SubtitlesPage({@required this.file, this.imdbID});

  @override
  _SubtitlesPageState createState() => _SubtitlesPageState();
}

class _SubtitlesPageState extends State<SubtitlesPage> {
  List<Subtitle> subtitles = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getSubtitles();
  }

  void getSubtitles() {
    setState(() {
      _isLoading = true;
    });
    // OpenSubs.fetch(file: widget.file, imdbID: widget.imdbID)
    //     .then((subtitleList) {
    //   setState(() {
    //     subtitles = subtitleList;
    //     _isLoading = false;
    //   });
    // });
  }

  void _downloadSub(Subtitle subtitle) async {
    setState(() {
      _isLoading = true;
    });
    downloadSub(subtitle: subtitle, movieFile: widget.file)
        .then((download) => setState(() {
              _isLoading = false;
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Download finished'),
              ));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Select a Subtitle'),
      ),
      body: ModalProgressHUD(
        child: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            return SubtitleTile(subtitles[index], _downloadSub);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: subtitles.length,
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }
}
