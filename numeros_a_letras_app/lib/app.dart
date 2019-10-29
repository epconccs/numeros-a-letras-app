import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numeros_a_letras_app/screens/about/about_screen.dart';
import 'package:numeros_a_letras_app/screens/main/main_screen.dart';

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
        '/': (context) => MainScreen(),
        //'/game': (context) => GameScreen()
      },
    );
  }
}