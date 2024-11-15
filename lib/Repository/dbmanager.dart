import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBManager {

  static Future<Database> GetSongsDB() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    int oldversion = 0;
    final database = openDatabase(
      join(documentsDirectory.path, 'ah_songs_db.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE favsongs(songno INTEGER, PRIMARY KEY (songno))",
        );
        db.execute(
          "CREATE TABLE playlists(playlistid INTEGER PRIMARY KEY, playlistname TEXT NOT NULL);",
        );

        db.execute(
          "CREATE TABLE playlistsongs(playlistid INTEGER, songno INTEGER, title TEXT, order INTEGER, PRIMARY KEY (playlistid, songno));",
        );
      },
      onUpgrade: (db, oldversion, version){
        db.execute(
          "CREATE TABLE playlists(playlistid INTEGER PRIMARY KEY, playlistname TEXT NOT NULL);",
        );

        db.execute(
          "CREATE TABLE playlistsongs(playlistid INTEGER, songno INTEGER, title TEXT, order INTEGER, PRIMARY KEY (playlistid, songno));",
        );
      } ,
      version: 1,
    );
    return database;
  }
}