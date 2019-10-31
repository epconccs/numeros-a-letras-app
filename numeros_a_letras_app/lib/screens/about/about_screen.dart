import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/utils/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  double widthScreen = 0.0;
  double heightScreen = 0.0;
  bool isLargeScreen;
  var paddingTop;
  @override
  Widget build(BuildContext context) {
    // obtener el ancho y alto de la pantalla.
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;

     // El equivalente de "smallestWidth" en Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // Para saber si es tablet o si es smartphone se basa en el ancho de la pantalla
    // Si es menor a 600 es un teléfono
    isLargeScreen = shortestSide > 600;  
   

    // alto SafeArea
    var padding = MediaQuery.of(context).padding;
    paddingTop = isLargeScreen ? (padding.top *2): padding.top;
    var height1 = heightScreen - padding.top - padding.bottom;

    var fontSizeText = isLargeScreen ? 22.0 : 13.0;

    var heightNalLogo = heightScreen * 0.15;
    var widthNalLogo = widthScreen * 0.15;
    var heightEpconLogo = heightScreen * 0.1;
    var widthEpconLogo = widthScreen * 0.1;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          margin: EdgeInsets.only(top: paddingTop),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: paddingTop),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ImageView('assets/img/logo-nal-nuevo.webp',
                            heightNalLogo, widthNalLogo),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: paddingTop),
                    width: widthScreen * 0.5,
                    child: Text(
                      "NAL es un proyecto diseñado y desarrollado en México por EPCON CCS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 96, 95, 95),
                          fontFamily: 'Poppins',
                          fontSize: fontSizeText,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: paddingTop),
                    width: widthScreen * 0.6,
                    child: Text(
                      "¡Muchas gracias por usar NAL!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 96, 95, 95),
                          fontSize: fontSizeText,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: paddingTop),
                    width: widthScreen * 0.6,
                    child: Text(
                      "Con tu apoyo seguiremos desarrollando más y mejores apps :)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 96, 95, 95),
                          fontFamily: 'Poppins',
                          fontSize: fontSizeText,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => _launchURL(),
                      child: Container(
                          margin: EdgeInsets.only(top: paddingTop),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ImageView('assets/img/icono-logo-epcon.webp',
                                heightEpconLogo, widthEpconLogo),
                          ))),
                  GestureDetector(
                      onTap: () => _launchURL(),
                      child: Container(
                        margin: EdgeInsets.only(top: paddingTop / 2),
                        width: widthScreen * 0.6,
                        child: Text(
                          "www.epcon.com.mx",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 65, 87),
                              fontFamily: 'Poppins',
                              fontSize: fontSizeText,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                  getGithubButton()
                ],
              ),
              getBackButton()
            ],
          ),
        ));
  }

  //Método para obtener el botón para ir a pantalla principal
  getBackButton() {
    var multiplierWidth = isLargeScreen ?  0.8 : 0.7;
    var multiplierHeight = isLargeScreen ? 0.87 : 0.8;
    return Positioned(
        right: widthScreen * multiplierWidth,
        top: heightScreen * multiplierHeight,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: heightScreen * 0.95,
            child: ImageView('assets/img/about-close.webp', 200, 200),
            alignment: Alignment.topRight,
          ),
        ));
  }

//Método para obtener el botón de Contribuir en github
  getGithubButton() {
    final buttonWidth = widthScreen * 0.65;
    final buttonHeight = heightScreen * 0.067;
    var fontSizeText = isLargeScreen ? 22.0 : 13.0;
    return Container(
        margin: EdgeInsets.only(top: paddingTop),
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: Container(
            child: RaisedButton(
              onPressed: () => _launchURLGitHub(),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
              color: Color.fromARGB(255, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: ImageView('assets/img/logo-github.webp', 40, 40),
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
                              fontSize: fontSizeText,
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

  _launchURL() async {
    const url = 'https://epcon.com.mx';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLGitHub() async {
    const url = 'https://github.com/epconccs/numeros-a-letras-app';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
