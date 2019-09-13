import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/utils/image_widget.dart';
import 'package:numeros_a_letras_app/utils/shapes_painter.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  double widthScreen = 0.0;
  double heightScreen = 0.0;

  @override
  Widget build(BuildContext context) {
    // obtener el ancho y alto de la pantalla.
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;

    // alto SafeArea
    var padding = MediaQuery.of(context).padding;
    var height1 = heightScreen - padding.top - padding.bottom;

    var heightNalLogo = heightScreen * 0.2;
    var widthNalLogo = widthScreen * 0.2;
    var heightEpconLogo = heightScreen * 0.12;
    var widthEpconLogo = widthScreen * 0.12;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          margin: EdgeInsets.only(top: padding.top),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: padding.top),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ImageView('assets/img/logo-nal-nuevo.png',
                            heightNalLogo, widthNalLogo),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: padding.top),
                    width: widthScreen * 0.5,
                    child: Text(
                      "NAL es un proyecto diseñado y desarrollado en México por EPCON CSS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 96, 95, 95),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: padding.top),
                    width: widthScreen * 0.6,
                    child: Text(
                      "¡Muchas gracias por usar NAL!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 96, 95, 95),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: padding.top),
                    width: widthScreen * 0.6,
                    child: Text(
                      "Con tu apoyo seguiremos desarrollando más y mejores apps :)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 96, 95, 95),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: padding.top * 2),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ImageView('assets/img/icono-logo-epcon.png',
                            heightEpconLogo, widthEpconLogo),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: padding.top / 2),
                    width: widthScreen * 0.6,
                    child: Text(
                      "www.epcon.com.mx",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 65, 87),
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  getGithubButton()
                ],
              )
              ,getAboutButton()
            ],
          ),
        ));
  }

  //Método para obtener el botón de Contribuir en github
  /* getGithubButton() {
    final buttonWidth = widthScreen * 0.7;
    final buttonHeight = heightScreen * 0.07;

    return SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: RaisedButton(
          
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(50.0),
              side: BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
          onPressed: () {},
          color: Color.fromARGB(255, 0, 0, 0),
          elevation: 0.0,
          textColor: Colors.white,
          child: Text("Contribuye en GitHub",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400)),
        ));
  }*/
  //Método para obtener el botón ACERCA DE
  getAboutButton() {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        CustomPaint(
          painter: ShapesPainter(),
          child: Container(
            height: 700,
            child: ImageView('assets/img/about.png', 40, 40),
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.fromLTRB(50, 0, 0, 10),
          ),
        ),
      ],
    );
  }

  getGithubButton() {
    final buttonWidth = widthScreen * 0.65;
    final buttonHeight = heightScreen * 0.067;

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: Container(
            child: RaisedButton(
              onPressed: () => {},
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
              color: Color.fromARGB(255, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: ImageView('assets/img/logo-github.png', 40, 40),
                    flex: 1,
                  ),
                  Flexible(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Contribuye en Github',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        )),
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
