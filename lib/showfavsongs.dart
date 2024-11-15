import 'package:assemblyhymns/Models/SongIndex.dart';
import 'package:flutter/material.dart';
import 'package:assemblyhymns/Models/SongIndex.dart';
import 'package:assemblyhymns/Repository/songsrepository.dart';
import 'showsong.dart';
import 'package:assemblyhymns/Repository/favsongrepository.dart';
import 'sidemenu.dart';

class ShowFavSongs extends StatefulWidget {
  ShowFavSongs({Key? key}) : super(key: key);
  @override
  _ShowFavSongsState createState() => _ShowFavSongsState();
}

class _ShowFavSongsState extends State<ShowFavSongs>
{
  List<SongIndex> favSongs = [];
  int index=0;
  int languageIndex = 0;
  @override
  void initState() {
      super.initState();
      getFavSongs();
  }

  void getFavSongs() async
  {
    print("Before GetFavouriteSongs");
    var _favSongs = await SongRepository.GetFavouriteSongs();
    print(_favSongs);
    setState(() {
      favSongs.clear();
      favSongs.addAll(_favSongs);
    });
  }

  Widget build(BuildContext context)    {
    return Scaffold(
        appBar:
        AppBar(
          title: Text("Favourites"),
          actions: <Widget>[
            /*InkWell(
              child: CircleAvatar(backgroundColor: Theme.of(context).primaryColor, child:
              Text(languageIndex == 0 ? "En":"Ml", style: TextStyle(color: Colors.white),),),
              onTap: (){
                setState(() {
                  if(languageIndex == 0) languageIndex = 1;
                  else languageIndex = 0;
                });
              },
            ),*/
          ],
        ),
        drawer: SideMenu(),
        body:
        Container(
          child:
          favSongs.length > 0 ? Column(
            children: <Widget>[
              Expanded(child:
              ListView.builder(
                  itemCount: favSongs.length,
                  itemBuilder: (context, index){
                    return InkWell(
                        child: Container(
                            child:
                            Card(
                                elevation: 0.5,
                                margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
                                child:
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: ()
                                          {
                                            showDeleteConfirmationDialog(context, index);
                                            /*FavSongsRepository.RemoveFavSong(favSongs[index].SongNo);
                                            setState(() {
                                              favSongs.removeAt(index);
                                            });*/
                                          },
                                        ),
                                      )
                                      ,
                                      Expanded(
                                        flex: 6,
                                        child: Text(favSongs[index].Title),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(favSongs[index].SongNo.toString()),
                                      ),
                                    ],
                                  ),
                                )

                            )
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShowSong(songno: favSongs[index].SongNo,)),
                          );
                        }
                    );
                  }
              ),
              )
            ],
          ): Center(child: Text("No Favorites"),),
        )
    );
  }

  showDeleteConfirmationDialog(BuildContext context, int index) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed:  () {
        Navigator.pop(context);
        FavSongsRepository.RemoveFavSong(favSongs[index].SongNo);
        setState(() {
          favSongs.removeAt(index);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to delete from favorites?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
