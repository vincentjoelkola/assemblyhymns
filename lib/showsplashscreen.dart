import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import  'package:assemblyhymns/utility.dart';
import 'package:assemblyhymns/showsong.dart';



class ShowSplashScreen extends StatefulWidget
{
  @override
  _ShowSplashScreenState createState() => _ShowSplashScreenState();
}

class _ShowSplashScreenState extends State<ShowSplashScreen>
{
  bool isversionMismtach = false;
  String PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.vincentbiblesearch.assemblyhymns';
  @override
  void initState() {
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    navigateToHome();
    super.initState();

  }

  void navigateToHome()
  {
   Future.delayed(Duration(seconds: 5),(){
      if(!isversionMismtach)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ShowSong()),
      );
    });
  }

  versionCheck(context) async {
    print("versionCheck");
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    print("currentVersion");
    print(currentVersion);
    //Get Latest version info from firebase config
    final FirebaseRemoteConfig remoteConfig = await FirebaseRemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      remoteConfig.getString('ah_current_version');
      double newVersion = double.parse(remoteConfig
          .getString('ah_current_version')
          .trim()
          .replaceAll(".", ""));

      print("newVersion");
      print(newVersion);

      if (newVersion > currentVersion) {
        isversionMismtach  = true;
        _showVersionDialog(context);
      }
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('data/spl.jpg'),
            ),
            color: Colors.white,
          ),
        ),
      );


  }

  _showVersionDialog(context) async {
    print("_showVersionDialog");
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(btnLabel),
              onPressed: () => Utility.MakePhoneCall(PLAY_STORE_URL),
            ),
            TextButton(
              child: Text(btnLabelCancel),
              onPressed: () {
                isversionMismtach = false;
                navigateToHome();
              },
            ),
          ],
        );
      },
    );
  }
}
