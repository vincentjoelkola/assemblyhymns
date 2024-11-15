import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sidemenu.dart';

class OtherApps extends StatelessWidget{
  double _fontSize = 15.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Apps"),
      ),
      drawer: SideMenu(),
      body:

      Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child:
        Column(
          children: <Widget>[
            ListView(
              shrinkWrap:true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Text("Vincent Bible Search", style: TextStyle(fontWeight:FontWeight.bold)),
                Text("\n"),
                Text("Vincent Bible Search is used to search Bible in English/Telugu languages."
                    "It has Telugu/KJV/ESV version Bibles. It has other features like labeling, writing sermon notes, search history.\n",),
                ElevatedButton(
                  //color: Theme.of(context).primaryColor,
                  child: Text("Click here to download", style: TextStyle(color: Colors.white),),
                  onPressed: ()
                  {
                    launch("https://play.google.com/store/apps/details?id=com.vincentbiblesearch.telugu");
                  },
                )
              ],
            ),
            Divider(),
            ListView(
              shrinkWrap:true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Text("Christava Sunada Keerthanalu", style: TextStyle(fontWeight:FontWeight.bold)),
                Text("\n"),
                Text("Telugu Brethren songs with audio and lyrics\n"),
                ElevatedButton(
                  //color:Theme.of(context).primaryColor,
                  child: Text("Click here to download", style: TextStyle(color: Colors.white),),
                  onPressed: ()
                  {
                    launch("https://play.google.com/store/apps/details?id=com.vincentbiblesearch.csk");
                  },
                )
              ],
            ),
            Divider(),
            ListView(
              shrinkWrap:true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Text("Athmeeya Geethangal", style: TextStyle(fontWeight:FontWeight.bold)),
                Text("\n"),
                Text("Malayalam Brethren songs with audio and lyrics\n"),
                ElevatedButton(
                  //color:Theme.of(context).primaryColor,
                  child: Text("Click here to download", style: TextStyle(color: Colors.white),),
                  onPressed: ()
                  {
                    launch("https://play.google.com/store/apps/details?id=com.vincentbiblesearch.athmeeyageethangal");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



