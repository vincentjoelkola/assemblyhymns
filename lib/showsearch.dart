import 'package:flutter/material.dart';
import 'package:assemblyhymns/Models/Index.dart';
import 'package:assemblyhymns/Models/SongIndex.dart';
import 'package:assemblyhymns/Repository/songsrepository.dart';
import 'showsong.dart';

class ShowSearch extends StatefulWidget {
  ShowSearch({Key? key}) : super(key: key);
  @override
  _ShowSearchState createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch>
{
  late TextEditingController _controller;
  String searchText = "";
  late Future<List<Index>> fetchSongs;

  @override
  void initState() {
    fetchSongs = SongRepository.GetSongIndex() as Future<List<Index>>;
    _controller = new TextEditingController();
    _controller.addListener(onkeywordChange);
    super.initState();
  }

  void onkeywordChange(){
    setState(() {
      searchText = _controller.text.toLowerCase();
    });
  }

  Widget build(BuildContext context)    {
    return Scaffold(
        appBar:
        AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
            Navigator.pop(context);
          }),
          title: TextField(
            style: TextStyle(color: Colors.white),
            controller: _controller,
            autofocus: true,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                focusColor: Colors.white,
                hintText: "Song no or Keyword",
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white
            ),
          ),
        ),
        body:
        FutureBuilder(
            future: fetchSongs,
            builder: (context, snapshot)
            {
              if(snapshot.connectionState == ConnectionState.done)
              {
                List<Index> _songs = snapshot.data as List<Index>;
                List<SongIndex> newSongsList = [];

                if(searchText.trim() != "" && searchText != null)
                {
                  int? songno = int.tryParse(searchText);

                  if(songno != null) {
                    _songs.forEach((s) {
                      s.AlphaIndices?.forEach((element) {
                        element.SongIndices?.forEach((s) {
                             if(s.SongNo == songno)
                             newSongsList.add(s);
                        });

                      });
                    });
                  }
                  else
                  {
                    print("searchText: "+ searchText);
                    //List<Song> bodySongs = new List<Song>();

                  /*_songs.forEach((s) {
                    s.AlphaIndices?.forEach((element) {
                      element.SongIndices?.forEach((element1) {

                      });
                    });
                  });

                    _songs.forEach((s) {
                      if(searchText.toLowerCase().indexOf("w:") == 0)
                      {
                        var inputwriter = searchText.trim().replaceAll("w:", "");
                        if(s. != null && s.Writer.toLowerCase().indexOf(inputwriter) > -1)
                        {
                          s.SubTitle = s.Writer;
                          newSongsList.add(s);
                        }
                      }
                      else {
                        var titleindex = s.Title.trim()
                            .toLowerCase()
                            .indexOf(searchText);
                        if (titleindex > -1) {
                          s.SubTitle = s.Title;
                          s.searchIndex = titleindex;
                          newSongsList.add(s);
                        } else {
                          var lyricArr = s.Lyrics[0].split("\n");
                          for (final line in lyricArr) {
                            var index = line.trim().toLowerCase().indexOf(
                                searchText);
                            if (index > -1) {
                              s.SubTitle = line;
                              s.searchIndex = index;
                              bodySongs.add(s);
                              break;
                            }
                          }

                          if (!newSongsList.contains(s) && !bodySongs.contains(s)) {
                            var lyricArr = s.Lyrics[1].split("\n");

                            for (final line in lyricArr) {
                              var index = line.trim().toLowerCase().indexOf(
                                  searchText);
                              if (index > -1) {
                                s.SubTitle = line;
                                s.searchIndex = index;
                                bodySongs.add(s);
                                break;
                              }
                            }
                          }
                        }
                      }
                    });

                    newSongsList.sort((a,b)=> a.searchIndex.compareTo(b.searchIndex));
                    bodySongs.sort((a,b)=> a.searchIndex.compareTo(b.searchIndex));
                    newSongsList.addAll(bodySongs);*/
                  }
                }


                return ListView.builder(
                    itemCount: newSongsList.length,
                    itemBuilder: (context, index) {
                      return
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    ShowSong(
                                      songno: newSongsList[index].SongNo,)));
                          },
                          child: Card(
                              elevation: 0.5,
                              margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
                              child:
                              Container(
                                  padding: EdgeInsets.only(left: 5.0,
                                      right: 5.0,
                                      top: 5.0,
                                      bottom: 5.0),
                                  child:
                                  ListTile(
                                      leading: Text(newSongsList[index].SongNo
                                          .toString()),
                                      title: Text(newSongsList[index].Title))
                              )
                          ),
                        );
                        }
                        );




              }else
              {
                return Container(
                );
              }
            }
        )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
}