import 'package:flutter/material.dart';
import 'myinheritedwidget.dart';
import 'package:assemblyhymns/Models/Song.dart';
import 'package:assemblyhymns/Repository/songsrepository.dart';
import 'package:assemblyhymns/sidemenu.dart';
import  'package:assemblyhymns/utility.dart';
import 'package:assemblyhymns/choice.dart';
import 'package:assemblyhymns/fontdailog.dart';
import 'package:assemblyhymns/showsearch.dart';
import 'package:assemblyhymns/favcontrol.dart';


class ShowSong extends StatefulWidget {
  final songno;
  ShowSong({
    Key? key,
    this.songno
  }): super(key: key);

  @override
  ShowSongState createState() => new ShowSongState();

  static ShowSongState? of(BuildContext context) {
    if(context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>() != null)
      return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!.data;
    else null;
  }
}

class ShowSongState extends State<ShowSong>
{
  int songno = 1;
  Song? song = null;
  int languageIndex = 0;
  String keyword="";
  bool isSearching = false;
  TextEditingController controller = new TextEditingController();
  double fontSize = 16;
  bool fromDiffPage = false;
  bool toggleEnabled = false;

  //String get songCategory => null;

  void setSongNo(sno){
    songno = sno;
    fromDiffPage = true;
  }

  void getSong() async
  {
    var _song = await SongRepository.GetSong(songno);
    setState(() {
      song = _song;
      languageIndex = 0;
      int? x = song?.Lyrics.length;
      if(x! >1) toggleEnabled = true;
      else toggleEnabled = false;
    });
  }

  void incrementSong() async
  {
    if(songno < 464)
      songno++;
    else songno = 1;
    getSong();
  }

  void decrementSong() async
  {
    if(songno > 1)
      songno--;
    else songno = 464;
    getSong();
  }

  void toggleLanguage() async
  {
    setState(() {
      if(languageIndex == 0) languageIndex = 1;
      else languageIndex = 0;
    });

  }

  void SetFontSize(double size) async
  {
    setState(() {
      fontSize = size;
    });
  }

  void LoadFontSize() async
  {
    var size = await Utility.GetFontSize();
    setState(() {
      fontSize = size;
    });
  }

  void gotoSearch(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSearch()));
  }
  void shareSong() async
  {
    print("shareSong");
    if(song != null)
    {
      print("in if");
      var songlyrics = song!.Lyrics![languageIndex].trim();
      print(songlyrics);
      Utility.ShareSong(songlyrics);
    }
  }


  @override
  void initState() {
    if(widget.songno != null)
    {
      setSongNo(widget.songno);
    }
    getSong();
    LoadFontSize();
    super.initState();
}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    //return Container(child: Text("testing"),);
    return MyInheritedWidget(
      data: this,
      child: ShowSongBody()
      /*WillPopScope(
          child:ShowSongBody(),
          ),*/
    );
  }


}

class ShowSongBody extends StatefulWidget {
  ShowSongBody({Key? key}) : super(key: key);
  @override
  _ShowBodyState createState() => _ShowBodyState();
}

class _ShowBodyState extends State<ShowSongBody>
{


  Widget build(BuildContext context)    {

    return Scaffold(
        appBar:
        AppBar(
          //leading: ShowSong.of(context).fromDiffPage? IconButton(icon:Icon(Icons.arrow_back)):null,
          title: Text("Home"),
          actions: <Widget>[
            FavControl(),
            if(ShowSong.of(context)?.toggleEnabled != null && ShowSong.of(context)?.toggleEnabled == true)
              IconButton(icon: Icon(Icons.language, color: Colors.white,), onPressed: (){
                ShowSong.of(context)?.toggleLanguage();
              },),
            /*InkWell(
              child: CircleAvatar(backgroundColor: Theme.of(context).primaryColor, child:
              Text(ShowSong.of(context).languageIndex == 0 ? "En":"Ml", style: TextStyle(color: Colors.white),),),
              onTap: (){ShowSong.of(context).toggleLanguage();},
            ),*/
            IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){
              ShowSong.of(context)?.gotoSearch();
            },),
            PopupMenuButton<Choice>(
              //onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                      value: choice,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Column(
                            children: [
                              Column(
                                children: [
                                  Center(child: Icon(choice.icon,size:22.0, color: Colors.black,)),
                                ],
                              ),
                            ],
                          ),
                          tooltip: 'Menu',
                          onPressed: () {
                            if(choice.title == "Share"){
                              ShowSong.of(context)?.shareSong();
                            }
                            else if(choice.title == "FontSize"){
                              var fontsize = ShowSong.of(context)?.fontSize;
                              showDialog(
                                  context:context,
                                  builder:(BuildContext context1)
                                  {
                                    return FontDailog(fontsize!,(value)
                                    {
                                      ShowSong.of(context)?.SetFontSize(value);
                                    });
                                    ;
                                  }
                              );
                            }
                          },
                        ),
                      )
                  );
                }).toList();
              },
            )

          ],
        ),
        drawer: SideMenu(), //ShowSong.of(context).fromDiffPage? null: SideMenu(),
        body:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child:
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: (){
                        ShowSong.of(context)!.decrementSong();
                      },
                    )),
                Expanded(
                    flex: 3,
                    child:
                    Center(
                        child: Text("Song "+ ShowSong.of(context)!.songno.toString(), style: TextStyle(fontSize: 20),)
                    )),
                Expanded(
                    flex: 1,
                    child:
                    IconButton(
                      icon: Icon(Icons.arrow_forward,),
                      onPressed: (){
                        ShowSong.of(context)!.incrementSong();
                      },
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right:10.0, top:5.0, bottom: 5.0),
                  //child: Text(ShowSong.of(context)!.songCategory, style: TextStyle(color: Colors.purple),),
                )
              ],
            ),
            Expanded(child: Container(
                child: SongLyrics())
            )
          ],
        )
    );
  }

  /*void _select(Choice choice) {
    print(choice.title);
    if(choice.title == "Share"){
      ShowSong.of(context).shareSong();
    }
    else if(choice.title == "FontSize"){
      var fontsize = ShowSong.of(context)?.fontSize;
      showDialog(
          context:context,
          builder:(BuildContext context1)
          {
            return FontDailog(fontsize!,(value)
            {
              ShowSong.of(context)?.SetFontSize(value);
            });
            ;
          }
      );
    }

  }*/
}

class SongLyrics extends StatefulWidget {
  const SongLyrics({Key? key}) : super(key: key);

  @override
  _SongLyricsState createState() => _SongLyricsState();
}

class _SongLyricsState extends State<SongLyrics> {
  late Song? _song;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /*ShowSongState? data = ShowSong.of(context);
    _song = data?.song;*/
    _song = ShowSong.of(context)?.song;
  }

  @override
  void initState() {
    super.initState();
    _song = null;
  }

  @override
  Widget build(BuildContext context) {
    print("song");
    print(_song);
    if(_song != null){
      var songLyrics = _song!.Lyrics![ShowSong.of(context)!.languageIndex];
      var lyrisarr = songLyrics.split("n:");
      String? writer  = _song!.Writer;
      if(_song!.Writer != null && _song!.Writer!.trim() != ""){
        lyrisarr.add("W:"+ writer!);
      }


      String prevChar = "";
      List<String> newlyricArr = <String>[];

      lyrisarr.forEach((line){
        if(line.contains("||"))
          {
            var charanams = line.split("||");
            newlyricArr.add(charanams[0]);
            newlyricArr.add("||" + charanams[1]+ "||");
          }else {
            newlyricArr.add(line);
          }
      });

      var fontsize = ShowSong.of(context)!.fontSize;
      return ListView.builder(
          itemCount: newlyricArr.length,
          itemBuilder: (context, index){
            var line = newlyricArr[index].trim();
            if(line.indexOf("~") == 0)
            {
              line = line.replaceAll("~", "").trim();
            }

            if(line.indexOf("T:i:") == 0)
            {
              line  = line.replaceAll("T:i:", "");
              line  = "     "+line;
              return Container(
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize, fontStyle: FontStyle.italic, fontFamily: 'BookManOldStyle'),),
              );
            }
            else if(line.indexOf("i:") == 0)
            {
              line  = line.replaceAll("i:", "");
              return Container(
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize, fontStyle: FontStyle.italic, fontFamily: 'BookManOldStyle'),),
              );
            }
            else if(line.indexOf("T:") == 0)
            {
              line  = line.replaceAll("T:", "");
              line  = "     "+line;
              return Container(
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize, fontStyle: FontStyle.italic, fontFamily: 'BookManOldStyle'),),
              );
            }
            else if(line.indexOf("W:") == 0)
            {
              line  = "--- "+line.replaceAll("W:", "");
              return Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize, fontStyle: FontStyle.italic,),),
              );
            }
            else if(line.indexOf("||") == 0)
            {
              return Container(
                alignment: AlignmentDirectional.bottomEnd,
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize),),
              );
            }
            else if(index == lyrisarr.length-1 && line.trim().length < 6)
            {
              line  = "--- "+line.replaceAll("W:", "");
              return Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize, fontStyle: FontStyle.italic,),),
              );
            }
            else
              return Container(
                padding: EdgeInsets.only(left:10, right: 10, bottom: 1),
                child: Text(line, style: TextStyle(fontSize: fontsize, fontFamily: 'BookManOldStyle'),),
              );
          }
      );


    }
    else
    {
      return Text("Loading...");
    }
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Share', icon: Icons.share,),
  const Choice(title: 'FontSize', icon: Icons.format_size),
];
