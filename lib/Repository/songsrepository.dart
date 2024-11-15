import 'package:assemblyhymns/Models/Song.dart';
import 'package:assemblyhymns/Models/SongIndex.dart';
import 'package:assemblyhymns/Models/Index.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:async/async.dart';
import 'favsongrepository.dart';

class SongRepository {
  static List<Song> songsList = List.empty();
  static List<Index> indexList = List.empty();
  static AsyncMemoizer _indexMemoizer = new AsyncMemoizer();
  static AsyncMemoizer _memoizer = new AsyncMemoizer();

  static AsyncMemoizer _GetSongMemoizer()
  {
    /*if(_indexMemoizer != null)
    {
      return _indexMemoizer;
    }
    _indexMemoizer = new AsyncMemoizer();*/
    return _indexMemoizer;
  }

  static Future<List<Song>> GetAllSongs() async {
    if (songsList.isEmpty) {
      songsList = await _GetSongMemoizer().runOnce(() async {
        var indexJson = await rootBundle.loadString("data/songs.json");
        var songsIndex = jsonDecode(indexJson);
        var list = songsIndex as List;
        List<Song> songIndex = list.map((i) => Song.fromJson(i)).toList();
        return songIndex;
      });
    }
    return songsList;
  }

  static Future<Song> GetSong(sno) async {
    List<Song> allSongs = await GetAllSongs();
    var _song = null;
    allSongs.forEach((si){
      if(si.SongNo == sno){
        _song =si;
        return;
      }});
    return _song;
  }

  static Future<List<Index>> GetSongIndex() async {
    if (indexList.isEmpty) {
      indexList = await _memoizer.runOnce(() async {
        var indexJson = await rootBundle.loadString("data/index.json");
        var songsIndex = jsonDecode(indexJson);
        var list = songsIndex as List;
        List<Index> songIndex = list.map((i) => Index.fromJson(i)).toList();
        return songIndex;
      });
    }
    return indexList;
  }

  static Future<Index?> GetIndex(int i) async
  {
    List<Index>? allSongs = await GetSongIndex();
    Index _song = allSongs![i];
    List<int> favSongs = await FavSongsRepository.GetAllFavSongs();
    _song.AlphaIndices?.forEach((element) {
      element.SongIndices?.forEach((element1) {
          element1.IsFav = favSongs.contains(element1.SongNo);
      });
    });

    print(_song);
    return _song;
  }

  static Future<List<SongIndex>> GetFavouriteSongs() async {
    List<SongIndex> _songs = [];
    List<Index> allSongs = await GetSongIndex();
    List<int> favSongs = await FavSongsRepository.GetAllFavSongs();
    print("fav before");
    allSongs.forEach((si){
      si.AlphaIndices?.forEach((element) {
        element.SongIndices?.forEach((element1) {
          if(favSongs.contains(element1.SongNo))
          {
            _songs.add(element1);
          }
        });

      });
    });
    print("fav songs");
    print(_songs);
    return _songs;
  }

}