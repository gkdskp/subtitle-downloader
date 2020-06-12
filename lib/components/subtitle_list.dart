import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/subtitles_list.dart';
import '../components/subtitle_tile.dart';
import '../models/subtitles.dart';
import '../utils/unarchive.dart';
import '../services/opensub.dart';

class SubtitlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtitlesListBloc, List<Subtitle>>(
        builder: (context, subtitles) {
      return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        
        itemBuilder: (BuildContext context, int index) {
          return SubtitleTile(subtitles[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: subtitles.length,
      );
    });
  }
}
