import 'package:assemblyhymns/Models/SongIndex.dart';

class AlphaIndex {
  final String Letter;
  final List<SongIndex>? SongIndices;

  AlphaIndex({required this.Letter,required this.SongIndices});

  factory AlphaIndex.fromJson(Map<String, dynamic> json) {
    var list = json["songIndices"] as List;
    return AlphaIndex(
      Letter: json['Letter'],
      SongIndices: list.map((i) => SongIndex.fromJson(i)).toList(),
    );
  }
}


