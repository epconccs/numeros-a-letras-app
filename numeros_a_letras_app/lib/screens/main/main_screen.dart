import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 


  bool isTexfieldFocused = false;
  double widthScreen = 0.0;
  double heightScreen = 0.0;
  double heightWidthLogoNal = 150;
  var _focusNode = new FocusNode();
  String textLetters = "";

  @override
  Widget build(BuildContext context) {
    // full screen width and height
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
    double buttonMarginBottom = heightScreen * 0.05;

     // El equivalente de "smallestWidth" en Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    // Para saber si es tablet o si es smartphone se basa en el ancho de la pantalla
    // Si es menor a 600 es un teléfono
    final bool useMobileLayout = shortestSide < 600;  

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          isTexfieldFocused = true;
        } else {
          FocusScope.of(_focusNode.context).unfocus();
          isTexfieldFocused = false;
        }
        checkFocusTextfieldEvent();
      },
    );
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromARGB(244, 201, 255, 213),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(_focusNode.context).unfocus();
              isTexfieldFocused = false;
              checkFocusTextfieldEvent();
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
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: heightWidthLogoNal,
                          width: heightWidthLogoNal,
                          child: ImageView('assets/img/logo-nal-nuevo.webp',
                              heightWidthLogoNal, heightWidthLogoNal),
                        ),
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
    //Se agrega un listener para deteminar si tiene focus la caja de texto o no.
    _focusNode.addListener(() {
      _focusNode.hasFocus
          ? isTexfieldFocused = true
          : isTexfieldFocused = false;
      checkFocusTextfieldEvent();
    });
    return SizedBox(
      width: widthScreen * 0.8,
      child: TextField(
          controller: numberTextController,
          textInputAction: TextInputAction.done,
          autofocus: false,
          onEditingComplete: () => isTexfieldFocused = false,
          focusNode: _focusNode,
          inputFormatters: [
            DecimalTextInputFormatter(
                decimalRange: 2, activatedNegativeValues: false)
          ],
          keyboardType: TextInputType.text,
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
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutScreen())),
          child: Container(
            height: heightScreen * 0.95,
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
          onPressed: () {
            if (textLetters != "Letras" && textLetters != "") {
              ClipboardManager.copyToClipBoard(textLetters)
                  .then((result) {
                final snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text('Texto copiado' ,textAlign: TextAlign.center,),
                  
                );
                _scaffoldKey.currentState.showSnackBar(snackBar);
              });
            }
          },
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
      case NoInternetState:
          var snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text('No Tienes conexión a internet' ,textAlign: TextAlign.center,),
                );
                WidgetsBinding.instance.addPostFrameCallback((_) => _scaffoldKey.currentState.showSnackBar(snackBar));
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Letras',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 243, 123, 125))));
      
      case NalEmptyDataState:
        textLetters = (snapshotData as NalEmptyDataState).letters;
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
        var isEmptyDataState = false;
        if ((snapshotData as NalDataState).number.isNotEmpty &&
            numberTextController.text.isEmpty) {
          isEmptyDataState = true;
          textLetters = (snapshotData as NalDataState).letters;
        } else {
          textLetters = (snapshotData as NalDataState).number;
        }
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: isEmptyDataState
                ? Text((snapshotData as NalDataState).letters,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 243, 123, 125)))
                : Text((snapshotData as NalDataState).number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 243, 123, 125))));
      default:
    }
  }

  checkFocusTextfieldEvent() {
    if (isTexfieldFocused) {
      setState(() {
        heightWidthLogoNal = 100;
      });
    } else {
      setState(() {
        heightWidthLogoNal = 150;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (nalBloc != null) nalBloc.dispose();
  }
}
