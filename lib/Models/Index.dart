import 'package:assemblyhymns/Models/AlphaIndex.dart';

class Index {
  final String Language;
  final List<AlphaIndex>? AlphaIndices;

  Index({required this.Language,required this.AlphaIndices});

  factory Index.fromJson(Map<String, dynamic> json) {
    var list = json["alphaIndices"] as List;
    return Index(
      Language: json['Language'],
      AlphaIndices:  list.map((i) => AlphaIndex.fromJson(i)).toList()
    );
  }
}