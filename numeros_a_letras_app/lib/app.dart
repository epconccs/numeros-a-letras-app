import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splashscreen/splashscreen.dart';

class NalApp extends StatefulWidget {
  @override
  NalAppState createState() => NalAppState();
  
}

class NalAppState extends State<NalApp>{
 @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(),
      routes: {
        '/': (context) => SplashScreenNAL(),
        //'/game': (context) => GameScreen()
      },
    );
  }
}