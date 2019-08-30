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
            alignment: Alignment.topCenter,
            children: <Widget>[
              Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        CustomPaint(
                        painter: ShapesPainter(),
                        child: Container(
                          height: 700,
                          child: ImageView('assets/img/about.png', 40, 40),
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.fromLTRB(0, 60, 10, 0),
                        ),
                      ),
                      ],
                    ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageView('assets/img/logo-nal-nuevo.png',200,200),
                    TextField(
                      textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Color.fromARGB(255,71,144,181),
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Número' ,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(90,75,212,106),
                          style: BorderStyle.solid)),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(90,75,212,106) 
                            )
                            )
                            ),
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

class ImageView extends StatelessWidget {
  String _path ;
  double _height;
  double _width;
  Image image;
  ImageView( this._path,this._height,this._width);
  

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage(_path);
    Image image = Image(image: assetImage);
    return Container(
      child: image,
      height: _height,
      width: _height,
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint
    paint.color = Color.fromARGB(244, 157, 232, 174);
    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 1.03, size.height / 15);

    // draw the circle on centre of canvas having radius 75.0
    canvas.drawCircle(center, 75.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
