import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/utils/image_widget.dart';

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
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          margin: EdgeInsets.only(top: padding.top),
          child: Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: padding.top),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ImageView('assets/img/logo-nal-nuevo.png',
                        heightNalLogo, widthNalLogo),
                  )),
              Positioned(
                  top: heightNalLogo + (padding.top),
                  child:
                  Container(
                    width: widthScreen * 0.6,
                    margin: EdgeInsets.only(
                        top: padding.top),

                    child: 
                        Text(
                            "NAL es un proyecto diseñado y desarrollado por EPCON CCS",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 96, 95, 95),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500))
                  )                
                   )
            ],
          ),
        ));
  }
}
