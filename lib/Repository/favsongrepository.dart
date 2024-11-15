import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dbmanager.dart';

class FavSongsRepository {

  static Future<void> AddFavSong(int songNo) async {
    final Database db = await DBManager.GetSongsDB();
    print("db");
    print(db);
    await db.insert(
      'favsongs',
      {'songno': songNo.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> RemoveFavSong(int songNo) async {
    final Database db = await DBManager.GetSongsDB();
    await db.delete(
      'favsongs',
      where: "songno = ?",
      whereArgs: [songNo],
    );
  }

  static Future<List<int>> GetAllFavSongs() async {
    final Database db = await DBManager.GetSongsDB();
    final List<Map<String, dynamic>> maps = await db.rawQuery("select * from favsongs");
    print(maps);
    return List.generate(maps.length, (i) {
      return maps[i]['songno'];
    });
  }

  static Future<bool> IsFavSong(int songNo) async {
    final Database db = await DBManager.GetSongsDB();
    final List<Map<String, dynamic>> maps = await db.rawQuery("select * from favsongs where songno="+songNo.toString());
    if(maps.length > 0) return true;
    else return false;
  }

}