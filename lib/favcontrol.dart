import 'package:flutter/material.dart';
import 'package:assemblyhymns/showsong.dart';
import 'package:assemblyhymns/Repository/favsongrepository.dart';
import 'showfavsongs.dart';

class FavControl extends StatefulWidget {
  FavControl({Key? key}) : super(key: key);
  @override
  _FavControlState createState() => _FavControlState();
}

class _FavControlState extends State<FavControl>
{
  int songNo = 0;
  bool isFavSong = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    songNo = ShowSong.of(context)!.songno;
    if(songNo != 0) {
      findSongIsFav();
    }
  }

  void findSongIsFav() async{
    bool isfav = await FavSongsRepository.IsFavSong(songNo);
    setState(() {
      isFavSong = isfav;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isFavSong)
    {
      return IconButton(icon: Icon(Icons.favorite,color: Colors.white), onPressed: (){
        FavSongsRepository.RemoveFavSong(songNo);
        setState(() {
          isFavSong = false;
        });

        final snackBar = SnackBar(
          content: Text('Removed from favourites'),
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

      },);
    }
    else {
      return IconButton(icon: Icon(Icons.favorite_border,color: Colors.white), onPressed: (){
        FavSongsRepository.AddFavSong(songNo);
        setState(() {
          isFavSong = true;
        });

        final snackBar = SnackBar(
          content: Text('Added to favourites'),
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

      },);
    }
  }

}