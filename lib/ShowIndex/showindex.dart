import 'package:flutter/material.dart';
import '../myinheritedwidget.dart';
import '../models/song.dart';
import '../sidemenu.dart';
import '../showsong.dart';
import 'package:assemblyhymns/Models/Index.dart';
import 'package:assemblyhymns/Repository/songsrepository.dart';
import 'package:assemblyhymns/ShowIndex/showalphabets.dart';
import 'package:assemblyhymns/ShowIndex/showindexsongs.dart';
import 'showlanguages.dart';
import 'package:assemblyhymns/Repository/favsongrepository.dart';

/*import 'repository/favsongrepository.dart';
import 'showfavsongs.dart';
import 'showsearch.dart';*/

class ShowIndex extends StatefulWidget {
  final int language;
  ShowIndex({
    Key? key, required this.language
  }): super(key: key);

  @override
  ShowIndexState createState() => new ShowIndexState();

  static ShowIndexState? of(BuildContext context) {
    if(context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>() != null)
      return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!.data;
    else null;
  }
}

class ShowIndexState extends State<ShowIndex>
{
  int alphabetIndex = 0;
  Index? songsIndex = null;
  int alphabetCount = 0;
  int languageIndex = 0;
  String language = "";
  List<String> alLanguages =  ['English','Hindi','Malayalam','Tamil','Telugu','Bengali','Extra Songs'];
  void getSongs() async
  {
    var _songsIndex = await SongRepository.GetIndex(languageIndex);
    setState(() {
      songsIndex = _songsIndex;
    });
  }

  String get selectedLanguage{
    return alLanguages[languageIndex];
  }

  void toggleLanguage() async
  {
    setState(() {
      if(languageIndex == 0) languageIndex = 1;
      else languageIndex = 0;
    });

  }

  void toggleFav(int index, int songno, bool val) async
  {
    setState(() {
      songsIndex!.AlphaIndices![alphabetIndex].SongIndices?[index]?.IsFav = val;
    });
    if(val)
      FavSongsRepository.AddFavSong(songno);
    else FavSongsRepository.RemoveFavSong(songno);
  }

  void setLanguageIndex(String language) async
  {
    setState(() {
      languageIndex = alLanguages.indexOf(language);
      alphabetIndex = 0;
    });
    getSongs();
  }

  void setLanguageIndexNew(int index) async
  {
    setState(() {
      languageIndex = index;
      alphabetIndex = 0;
    });
    getSongs();
  }

  void setIndex(int i) async
  {
    setState(() {
      alphabetIndex = i;
    });
    getSongs();
  }

  void incrementIndex() async
  {
    print("incrementIndex");

    if(alphabetIndex < alphabetCount-1)
      alphabetIndex++;
    else alphabetIndex = 0;
    print(alphabetIndex);
    getSongs();
  }

  void decrementIndex() async
  {
    print("decrementIndex");
    if(alphabetIndex > 0)
      alphabetIndex--;
    else alphabetIndex = alphabetCount-1;
    print(alphabetIndex);
    getSongs();
  }

  @override
  void initState() {
    //getAlphabets();
    languageIndex = widget.language;
    getSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return MyInheritedWidget(
      data: this,
      child: ShowIndexBody(),
    );
  }
}

class ShowIndexBody extends StatefulWidget {
  ShowIndexBody({Key? key}) : super(key: key);
  @override
  _ShowIndexBodyState createState() => _ShowIndexBodyState();
}

class _ShowIndexBodyState extends State<ShowIndexBody>
{

  Widget build(BuildContext context)    {

    var selectedLanguage = ShowIndex.of(context)?.selectedLanguage?? "";

    return Scaffold(
      appBar:
      AppBar(
        title: Text("Index"),
        actions: <Widget>[
          /*DropdownButton(
            hint:
             Text(selectedLanguage, style: TextStyle(color: Colors.white),),
             icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
            items: ShowIndex.of(context)?.alLanguages.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Text(items)
              );
            }
            ).toList(),
              onChanged: (String? newValue) {
                ShowIndex.of(context)?.setLanguageIndex(newValue!);
              },

          ),*/

        ],
      ),
      drawer: SideMenu(),
      body:  Column(
        children: <Widget>[
          /*Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Select Langauge: ") ,
              ),
              
              DropdownButton(
                hint:
                Text(selectedLanguage),
                icon: Icon(Icons.keyboard_arrow_down),
                items: ShowIndex.of(context)?.alLanguages.map((String items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Text(items)
                  );
                }
                ).toList(),
                onChanged: (String? newValue) {
                  ShowIndex.of(context)?.setLanguageIndex(newValue!);
                },

              ),
            ],
          ),*/
          ShowLanguages(),
          ShowAlphabets(),
          Expanded(
            child:
            GestureDetector(
              onHorizontalDragEnd: (details)
              {
                /*if (details.velocity.pixelsPerSecond.dx > 0) {
                  ShowIndex.of(context).decrementIndex();
                }else {
                  ShowIndex.of(context).incrementIndex();

                }*/
              },
              child:  ShowIndexSongs(),
            ),

          )
        ],
      ),
    );
  }


}


/*


*/
