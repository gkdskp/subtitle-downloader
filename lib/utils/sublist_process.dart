import '../data/subtitles.dart';

List<Subtitle> joinLists(List<Subtitle> listA, List<Subtitle> listB) {
  List<String> ids = [];
  listA.forEach((subtitle) {
    ids.add(subtitle.id);
  });
  return listA +
      listB.where((subtitle) {
        return !ids.contains(subtitle.id);
      }).toList();
}

void sortList(List<Subtitle> list) {
  list.sort((subA, subB) {
    if (subA.fileMatch == subB.fileMatch) {
      return double.parse(subB.subRating) > double.parse(subA.subRating)
          ? 1
          : double.parse(subB.subRating) != double.parse(subA.subRating)
              ? -1
              : int.parse(subB.noOfVotes) - int.parse(subA.noOfVotes);
    } else if (subA.fileMatch)
      return 1;
    else
      return -1;
  });
}
