import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/constants.dart';

class NALLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const NALLink({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          decoration: TextDecoration.underline,
          color: AppColors.nalBlue,
        ),
      ),
    );
  }
}
