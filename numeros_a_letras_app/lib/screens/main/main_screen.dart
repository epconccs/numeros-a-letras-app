import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _counter = 0;
  double widthScreen = 0.0;
  double heightScreen = 0.0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // full screen width and height
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
    double buttonMarginBottom = heightScreen * 0.05;

    return Scaffold(
        backgroundColor: Color.fromARGB(244, 201, 255, 213),
        body: Container(
          margin: EdgeInsets.only(bottom: buttonMarginBottom),
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageNalLogo(),
                    TextField(
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration()),
                    Text(
                      'Letras',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 243, 123, 125)),
                    ),
                  ],
                ),
              ),
              Positioned(
                  child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: getRoundedButton())),
            ],
          ),
        ));
  }

  getRoundedButton() {
    final buttonWidth = widthScreen * 0.7;
    final buttonHeight = heightScreen * 0.07;

    return SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
              side: BorderSide(color: Color.fromARGB(244, 157, 232, 174))),
          onPressed: () {},
          color: Color.fromARGB(244, 157, 232, 174),
          elevation: 0.0,
          textColor: Colors.white,
          child: Text("Copiar".toUpperCase(),
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500)),
        ));
  }
}
 class ImageNalLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/img/logo-nal-nuevo.png');
    Image image = Image(image: assetImage);
    return Container(child: image,);
  }
  }
