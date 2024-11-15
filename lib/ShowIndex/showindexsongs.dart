import 'package:flutter/material.dart';
import 'package:assemblyhymns/ShowIndex/showindex.dart';
import 'package:assemblyhymns/showsong.dart';
import 'package:assemblyhymns/showfavsongs.dart';

class ShowIndexSongs extends StatefulWidget {
  ShowIndexSongs({Key? key}) : super(key: key);
  @override
  _ShowIndexSongsState createState() => _ShowIndexSongsState();
}

class _ShowIndexSongsState extends State<ShowIndexSongs>
{
  /*List<Song> _songs = new List<Song>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ShowIndexState? data = ShowIndex.of(context);
    _songs.clear();
    _songs.addAll(data.indexSongs);
  }*/



  Widget build(BuildContext context){

    if(ShowIndex.of(context)!.songsIndex != null)
    {
      return Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: ShowIndex.of(context)!.songsIndex!.AlphaIndices![ShowIndex.of(context)!.alphabetIndex].SongIndices!.length,
              //scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)
              {
                var songIndices = ShowIndex.of(context)!.songsIndex!.AlphaIndices![ShowIndex.of(context)!.alphabetIndex].SongIndices;

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
                                      icon: Icon( songIndices![index].IsFav? Icons.favorite:
                                             Icons.favorite_border),
                                      color: Colors.redAccent,
                                      onPressed: ()
                                      {
                                        var statustxt = songIndices![index].IsFav ? 'Removed from favourites': 'Added to favourites';
                                        ShowIndex.of(context)?.toggleFav(index, songIndices![index].SongNo, !songIndices![index].IsFav);
                                        final snackBar = SnackBar(
                                          content: Text(statustxt),
                                          action: SnackBarAction(
                                            label: 'View',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => ShowFavSongs()),
                                              );
                                            },
                                          ),
                                        );

                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                    ),
                                  )
                                  ,
                                  Expanded(
                                    flex: 6,
                                    child: Text(songIndices![index].Title),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(songIndices![index].SongNo.toString()),
                                  ),
                                ],
                              ),
                            )

                        )
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowSong(songno: songIndices![index].SongNo,)),
                      );
                    }
                );
              })
      );
    }else{
      return Container();
    }

    /*return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _songs.length,
            //scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)
            {
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
                                    icon: _songs[index].IsFav ? Icon(Icons.favorite): Icon(Icons.favorite_border),
                                    color: Colors.redAccent,
                                    onPressed: ()
                                    {
                                      var statustxt = _songs[index].IsFav ? 'Removed from favourites': 'Added to favourites';
                                      ShowIndex.of(context).toggleFav(index);
                                      final snackBar = SnackBar(
                                        content: Text(statustxt),
                                        action: SnackBarAction(
                                          label: 'View',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ShowFavSongs()),
                                            );
                                          },
                                        ),
                                      );

                                      Scaffold.of(context).showSnackBar(snackBar);
                                    },
                                  ),
                                )
                                ,
                                Expanded(
                                  flex: 6,
                                  child: Text(ShowIndex.of(context).languageIndex == 0 ? _songs[index].Title:
                                  _songs[index].ETitle),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(_songs[index].SongNo.toString()),
                                ),
                              ],
                            ),
                          )

                      )
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowSong(songno: _songs[index].SongNo,)),
                    );
                  }
              );
            })
    );*/
  }


}