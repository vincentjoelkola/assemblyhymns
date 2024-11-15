
class SongIndex {
  final int SongNo;
  final String Title;
  bool IsFav = false;

  SongIndex({required this.SongNo,required this.Title});

  factory SongIndex.fromJson(Map<String, dynamic> json) {
     return SongIndex(
      SongNo: json['SongNo'],
      Title: json['Title'],
    );
  }
}



