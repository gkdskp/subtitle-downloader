import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:subtitle_downloader/blocs/select_file.dart';
import 'package:subtitle_downloader/blocs/subtitles_list.dart';
import 'package:subtitle_downloader/utils/launch_url.dart';
import 'package:subtitle_downloader/constants.dart';
import 'package:subtitle_downloader/components/browse_file.dart';
import 'package:subtitle_downloader/components/search_form.dart';
import 'package:subtitle_downloader/pages/subtitles_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          AppTitle,
          style: Theme.of(context).textTheme.headline6,
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            BrowseForm(),
            BlocBuilder<SelectFileBloc, File>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 30),
                    if (state.path != '') SearchForm(_loadSubtitlesPage)
                  ],
                );
              },
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        FlatButton(
          child: Text('Report an Issue'),
          onPressed: () => launchURL(IssueReportLink),
        ),
        FlatButton(
          child: Text('Subtitles by Opensubtitles.org'),
          onPressed: () => launchURL('https://opensubtitles.org'),
        )
      ],
    );
  }

  void _loadSubtitlesPage(File file, [String title]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<SubtitlesListBloc>(
          create: (context) => SubtitlesListBloc(),
          child: SubtitlesPage(file, title),
        ),
      ),
    );
  }
}
