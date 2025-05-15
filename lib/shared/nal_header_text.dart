import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/constants.dart';

class NALHeaderText extends StatelessWidget {
  final String text;
  const NALHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.nalRed,
      ),
    );
  }
}
