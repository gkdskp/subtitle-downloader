import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../components/browse_file.dart';
import '../components/search_form.dart';

import './subtitle_list.dart';
import './movie_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _selectedFile;
  String id;

  void _selectFile() async {
    File file = await FilePicker.getFile();
    setState(() {
      _selectedFile = file;
    });
  }

  void _setID(String id) {
    this.id = id;
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubtitlesPage(
          file: _selectedFile,
          imdbID: id,
        ),
      ),
    );
  }

  void _search({String title, int season, int episode}) async {
    if (title == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubtitlesPage(file: _selectedFile),
        ),
      );
    } else {
     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubtitlesPage(file: _selectedFile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subtitle Downloader'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BrowseForm(_selectedFile, _selectFile),
            SizedBox(height: 30),
            SearchForm(_search),
          ],
        ),
      ),
    );
  }
}
