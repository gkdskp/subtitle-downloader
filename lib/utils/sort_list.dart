import 'package:subtitle_downloader/models/subtitles.dart';

void sortList(List<Subtitle> list) {
  list.sort((subA, subB) {
    if (subA.fileMatch == subB.fileMatch) {
      return double.parse(subB.subRating) > double.parse(subA.subRating)
          ? 1
          : double.parse(subB.subRating) != double.parse(subA.subRating)
              ? -1
              : int.parse(subB.noOfVotes) - int.parse(subA.noOfVotes);
    } else if (subA.fileMatch) {
      return -1;
    } else {
      return 1;
    }
  });
}
