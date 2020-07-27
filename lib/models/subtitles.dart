class Subtitle {
  String _id;
  String _fileName;
  String _subRating;
  String _noOfVotes;
  String _subFormat;
  String _zipDownloadLink;
  bool _fileMatch;

  Subtitle._(
    this._id,
    this._fileName,
    this._subRating,
    this._noOfVotes,
    this._subFormat,
    this._zipDownloadLink,
    this._fileMatch,
  );

  factory Subtitle.fromAPI(Map<String, dynamic> subtitle) => Subtitle._(
        subtitle['IDSubtitleFile'],
        subtitle['SubFileName'],
        subtitle['SubRating'],
        subtitle['SubSumVotes'],
        subtitle['SubFormat'],
        subtitle['ZipDownloadLink'],
        subtitle['MatchedBy'] == 'moviehash',
      );

  String get id => this._id;
  String get fileName => this._fileName;
  String get subRating => this._subRating;
  String get noOfVotes => this._noOfVotes;
  String get subFormat => this._subFormat;
  String get zipDownloadLink => this._zipDownloadLink;
  bool get fileMatch => this._fileMatch;
}
