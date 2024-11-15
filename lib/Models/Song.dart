class Song {
  final int SongNo;
  final List<String> Lyrics;
  final String? Writer;

  Song({required this.SongNo,required this.Lyrics,required this.Writer});

  factory Song.fromJson(Map<String, dynamic> json) {
    var list = json["Lyrics"] as List;
    List<String> lyrics = list.map((i) => i.toString()).toList();
    return Song(
      SongNo: json['SongNo'],
      Writer: json['Writer'],
      Lyrics: lyrics,
    );
  }
}