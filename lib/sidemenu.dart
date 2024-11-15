import 'package:flutter/material.dart';
import 'showsong.dart';
import 'ShowIndex/showindex.dart';
import 'showfavsongs.dart';
import 'package:assemblyhymns/otherapps.dart';
import 'package:assemblyhymns/showcontact.dart';
import 'utility.dart';
/*import 'showabout.dart';
import 'showcontact.dart';
import 'utility.dart';
import 'otherapps.dart';
import 'showindex.dart';
import 'showcindex.dart';
import 'showwriters.dart';
import 'repository/audioutility.dart';*/

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:
        Container(
          color: Theme.of(context).primaryColor,//Colors.blueGrey,
          child:
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('data/logo.jpg'),
                  ),
                  color: Colors.white,
                ), child: Container(),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white,),
                title:
                Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowSong()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list, color: Colors.white,),
                title:
                Text('Alphabetical Index', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowIndex(language: 0,))
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.white),
                title: Text('Favourites', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowFavSongs()),
                  );

                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Colors.white),
                title: Text('Share the app', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Utility.ShareApp();
                },
              ),
              ListTile(
                leading: Icon(Icons.apps, color: Colors.white),
                title: Text('Other apps', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtherApps()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_phone, color: Colors.white),
                title: Text('Contact', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowContact()),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.rate_review, color: Colors.white),
                title: Text('Rate Us', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Utility.MakePhoneCall("https://play.google.com/store/apps/details?id=com.vincentbiblesearch.assemblyhymns");
                },
              ),
            ],
          ),
        )

    );
  }

  _goToIndexScreen(pagename) async
  {
    if (pagename == "Alphabetical Index") {
      await Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShowIndex(language: 0,))
        );
      });
    }
  }

}