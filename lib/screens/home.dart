import 'package:flutter/material.dart';
import 'package:numeros_a_letras_app/shared/nal_button.dart';
import 'package:numeros_a_letras_app/shared/nal_header_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
            child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 180),
                const SizedBox(height: 32),
                TextField(
                  onChanged: (value) {},
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                  ),
                ),
                const SizedBox(height: 32),
                const NALHeaderText('LETRAS'),
                const SizedBox(height: 32),
                NALButton(label: 'COPIAR', onPressed: () {}),
              ],
            )
          ],
        )),
      ),
    );
  }
}
