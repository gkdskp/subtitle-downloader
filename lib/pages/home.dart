import 'package:flutter/material.dart';

import '../components/browse_file.dart';
import '../components/search_form.dart';
import '../components/subtitle_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subtitle Downloader'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BrowseForm(),
            SearchForm(),
            SubtitlesPage(),
          ],
        ),
      ),
    );
  }
}
