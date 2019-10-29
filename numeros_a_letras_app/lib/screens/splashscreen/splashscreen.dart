import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/screens/main/main_screen.dart';
import 'package:numeros_a_letras_app/utils/image_widget.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenNAL extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenNAL>{
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
   
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MainScreen(),
      image: new Image(image: AssetImage('assets/img/icono-foreground-android.png')),
      backgroundColor: Color.fromARGB(244, 201, 255, 213),
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Color.fromARGB(255, 243, 123, 125),
    );
  }
}