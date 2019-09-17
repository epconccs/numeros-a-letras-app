import 'package:flutter/material.dart';

//Clase para dibujar el circulo de la esquina superior derecha
class ShapesPainter extends CustomPainter {
  double widthDivider ;
  double heightDivider ;
  ShapesPainter(this.widthDivider ,this.heightDivider);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint
    paint.color = Color.fromARGB(244, 157, 232, 174);
    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / widthDivider, size.height / heightDivider);

    // draw the circle on centre of canvas having radius 75.0
    canvas.drawCircle(center, 75.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}