import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numeros_a_letras_app/data/number_repository.dart';
import 'package:numeros_a_letras_app/screens/about/about_screen.dart';
import 'package:numeros_a_letras_app/screens/main/nal_bloc.dart';
import 'package:numeros_a_letras_app/screens/main/nal_event.dart';
import 'package:numeros_a_letras_app/screens/main/nal_state.dart';
import 'package:numeros_a_letras_app/utils/decimal_formater.dart';
import 'package:numeros_a_letras_app/utils/image_widget.dart';
import 'package:numeros_a_letras_app/utils/shapes_painter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NalBloc nalBloc = NalBloc(NumberRepository());
  final numberTextController = TextEditingController();
  bool isTexfieldFocused = false;
  double widthScreen = 0.0;
  double heightScreen = 0.0;

  @override
  Widget build(BuildContext context) {
    // full screen width and height
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
    double buttonMarginBottom = heightScreen * 0.05;

    return Scaffold(
        backgroundColor: Color.fromARGB(244, 201, 255, 213),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
            isTexfieldFocused = false;
            
          }, 
          child: Container(
          margin: EdgeInsets.only(bottom: buttonMarginBottom),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              getAboutButton(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageView('assets/img/logo-nal-nuevo.webp', 150, 150),
                    getTextfieldAndLabel(),
                    StreamBuilder<NalState>(
                        initialData: NalDataState("Letras"),
                        stream: nalBloc.number,
                        builder: getLettersLabel()),
                  ],
                ),
              ),
              Positioned(
                  child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: getRoundedButton())),
            ],
          ),
        )));
  }

  //Método para obtener las vistas centrales (Textfield y Label)
  getTextfieldAndLabel() {
    var _focusNode = new FocusNode();
    _focusNode.addListener(() {
      _focusNode.hasFocus
          ? isTexfieldFocused = true
          : isTexfieldFocused = false;
    });
    return SizedBox(
      width: widthScreen * 0.8,
      child: TextField(
          textInputAction: TextInputAction.done,
          onEditingComplete: () => isTexfieldFocused = false,
          focusNode: _focusNode,
          inputFormatters: [DecimalTextInputFormatter(decimalRange: 2, activatedNegativeValues:false)],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (String numberText) =>
              nalBloc.new_number_event_sink.add(NewNumberEvent(numberText)),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Color.fromARGB(255, 71, 144, 181),
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              hintText: 'Número',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(90, 75, 212, 106),
                      style: BorderStyle.solid)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(90, 75, 212, 106),
                      style: BorderStyle.solid)),
              hintStyle: TextStyle(color: Color.fromARGB(90, 75, 212, 106)))),
    );
  }

//Método para obtener el botón ACERCA DE
  getAboutButton() {
    return Positioned(
        left: widthScreen * 0.7,
        bottom: heightScreen * 0.1,
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutScreen()))
          ,
          child: Container(
            height: heightScreen*0.95,
            child: ImageView('assets/img/about-circle.webp', 200, 200),
            alignment: Alignment.topRight,
          ),
        ));
  }

//Método para obtener el botón de "COPIAR"
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

  //Método para obtener la label de Letras según el contenido del textfield
  getLettersLabel() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      return Container(child: getRequiredWidget(snapshot.data));
    };
  }

  getRequiredWidget(NalState snapshotData) {
    switch (snapshotData.runtimeType) {
      case NalLoadingState:
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 243, 123, 125))));
        break;
      case NalEmptyDataState:
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text((snapshotData as NalEmptyDataState).letters,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 243, 123, 125))));
      case NalDataState:
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text((snapshotData as NalDataState).number,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 243, 123, 125))));
      default:
    }
  }
  @override
  void dispose() {
    super.dispose();
    if(nalBloc != null )
    nalBloc.dispose();
  }

}
