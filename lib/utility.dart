import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Utility
{
  static Future<void> MakePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void ShareApp()
  {
    var sharetext = StringBuffer();
    sharetext.write("*Assembly Hymns A/N Islands*");
    sharetext.write("\n\n");
    sharetext.write("Multilingual Songs Book with English,Hindi,Malayalam, Tamil, Telugu, Bengali songs");
    sharetext.write("\n\n");
    sharetext.write("https://play.google.com/store/apps/details?id=com.vincentbiblesearch.assemblyhymns");
    Share.share(sharetext.toString());
  }


  static void SetFontSize(double size) async{
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setDouble("FONTSIZE", size);
  }

  static Future<double> GetFontSize() async{
    double fontsize = 16.0;
    /*final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getDouble("FONTSIZE") != null) {
      fontsize = prefs.getDouble("FONTSIZE");
    }*/
    return fontsize;
  }

  static void ShareSong(String songlyrics)
  {
    if(songlyrics.trim() != "") {
      songlyrics = songlyrics.replaceAll("~", "");
      songlyrics = songlyrics.replaceAll("T:", "");
      songlyrics = songlyrics.replaceAll("t:", "");
      songlyrics = songlyrics.replaceAll("i:", "");
      songlyrics = songlyrics.replaceAll("I:", "");
      songlyrics = songlyrics.replaceAll("W:", "");
      songlyrics = songlyrics.replaceAll("w:", "");
      songlyrics = "\n"+ songlyrics +
          "\n\nSource: Assembly Hymns A/N Islands\n\nhttps://play.google.com/store/apps/details?id=com.vincentbiblesearch.assemblyhymns";
      Share.share(songlyrics);
    }
  }

  /*static Future<String> findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    String? mypath= directory?.path.isEmpty ? "" : directory?.path;
    var _localPath = directory?.path!! + Platform.pathSeparator + 'Download';
    print(_localPath);
    return _localPath;
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> isAudioFileExistsLocally(int songno) async{
    print("isAudioFileExistsLocally");
    var dirPath = await findLocalPath();
    String songfile = songno.toString()+".mp3";
    print(songfile);
    File file = new File(await findLocalPath() + Platform.pathSeparator + songfile);
    bool isFileExists = await file.exists();
    print(isFileExists);
    return isFileExists;
  }

  static Future<void> deleteFile(int songno) async{
    var dirPath = await findLocalPath();
    String songfile = songno.toString()+".mp3";
    File file = new File(await findLocalPath() + Platform.pathSeparator + songfile);
    bool isFileExists = await file.exists();
    if(isFileExists)
    {
      file.deleteSync();
    }
  }

  static Future<String> songLocalPath(int songno) async{
    if(await isAudioFileExistsLocally(songno)) {
      var dirPath = await findLocalPath();
      String songfile = songno.toString() + ".mp3";
      File file = new File(
          await findLocalPath() + Platform.pathSeparator + songfile);
      return await findLocalPath() + Platform.pathSeparator + songfile;
    }else
    {
      String songfile = songno.toString() + ".mp3";
      String songUrl = "http://mlsongs.vincentbiblesearch.com/songs/" +
          songfile;
      return songUrl;
    }
  }*/
}