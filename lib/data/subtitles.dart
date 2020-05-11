class Subtitle {
  String id;
  String fileName;
  String subRating;
  String noOfVotes;
  String subFormat;
  String zipDownloadLink;
  bool fileMatch;

  Subtitle({
    this.id,
    this.fileName,
    this.subRating,
    this.noOfVotes,
    this.subFormat,
    this.zipDownloadLink,
    this.fileMatch,
  });

  factory Subtitle.fromAPI(Map<String, dynamic> subtitle) {
    return Subtitle(
      id: subtitle['IDSubtitleFile'],
      fileName: subtitle['SubFileName'],
      subRating: subtitle['SubRating'],
      noOfVotes: subtitle['SubSumVotes'],
      subFormat: subtitle['SubFormat'],
      zipDownloadLink: subtitle['ZipDownloadLink'],
      fileMatch: subtitle['MatchedBy'] == 'moviehash',
    );
  }
}
