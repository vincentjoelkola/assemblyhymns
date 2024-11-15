import 'package:flutter/material.dart';
import 'utility.dart';
import 'sidemenu.dart';

class ShowContact extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:
        AppBar(
          title: Text("Contact"),
        ),
        drawer: SideMenu(),
        body:

        Container(
            padding: EdgeInsets.all(10.0),
            child:
            Column(
                children: <Widget>[
                  Text("Contact Details of Evangelists"),
                  Text("of"),
                  Text("Andaman and Nicobar Islands"),
                  //Text("\n"),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. M.Joseph")),
                    Expanded(
                      flex: 2,
                      child: Text("+919474210202"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919474210202)');
                      }),
                    ),
                  ],
                  ),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. M.K.Sunny")),
                    Expanded(
                      flex: 2,
                      child: Text("+919933274282"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919933274282)');
                      }),
                    ),
                  ],
                  ),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. Selvakumar")),
                    Expanded(
                      flex: 2,
                      child: Text("+919434271474"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919434271474)');
                      }),
                    ),
                  ],
                  ),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. P.Phinehas")),
                    Expanded(
                      flex: 2,
                      child: Text("+919434217380"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919434217380)');
                      }),
                    ),
                  ],
                  ),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. Aby V.Joseph")),
                    Expanded(
                      flex: 2,
                      child: Text("+919474288444"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919474288444)');
                      }),
                    ),
                  ],
                  ),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. Maruthu Pandian")),
                    Expanded(
                      flex: 2,
                      child: Text("+919531835016"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919531835016)');
                      }),
                    ),
                  ],
                  ),
                  Row(children:
                  <Widget>[
                    Expanded(flex: 2, child: Text("Evg. Georgy Jacob")),
                    Expanded(
                      flex: 2,
                      child: Text("+919734014323"),),
                    Expanded(
                      flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919734014323)');
                      }),
                    ),
                  ],
                  ),

                  Divider(),
                  Text("Designed and Developed by"),
                  Text("Bro.Vincent Joel Kola"),
                  Text("Christian Brethren Assembly, Kanigiri, AP"),
                  Row(children:
                  <Widget>[
                    Expanded(
                      //flex: 1,
                      child: IconButton(icon: Icon(Icons.call), onPressed: (){
                        Utility.MakePhoneCall('tel:+919703319144)');
                      }),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("+919703319144"),),
                    Expanded(
                      //flex: 1,
                      child: IconButton(icon: Icon(Icons.message), onPressed: (){
                        var whatsappUrl ="whatsapp://send?phone=+919703319144";
                        Utility.MakePhoneCall(whatsappUrl);
                      }),
                    ),
                  ],
                  ),
                  Expanded(child:
                  RichText(
                      text:TextSpan(
                        text: "\n\nExpect great things from God. Attempt great things for God."" - William Carey ",
                        style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      )))
                ]

            )
        ));

  }

}