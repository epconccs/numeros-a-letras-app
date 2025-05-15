import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/constants.dart';

class NALButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;

  const NALButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.nalDarkGreen),
      child: Text(label,
          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800)),
    );
  }
}
