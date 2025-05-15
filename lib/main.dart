import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/screens/home.dart';
import 'package:numeros_a_letras_app/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: AppTheme.nalTheme,
    );
  }
}
