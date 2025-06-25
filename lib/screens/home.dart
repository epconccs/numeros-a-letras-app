import 'package:numeros_a_letras_app/shared/nal_button.dart';
import 'package:numeros_a_letras_app/shared/nal_header_text.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:numeros_a_letras_app/about_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _result = '';

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      if (value.isNotEmpty) {
        _convertToLetters(value);
      }
    });
  }

  Future<void> _convertToLetters(String number) async {
    try {
      final response = await http.get(Uri.parse('https://api.numerosaletras.com/NAL/?num=$number'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _result = data['letras'] ?? 'Error en la conversión';
        });
      } else {
        setState(() {
          _result = 'Error del servidor: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error de conexión';
      });
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _result));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Texto copiado al portapapeles')),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
    appBar: AppBar(
      title: const Text(''), 
      centerTitle: false,   
      backgroundColor: const Color.fromARGB(255, 191, 242, 209), 
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 245, 93, 107),    
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
        ),
      ],
    ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 180),
                const SizedBox(height: 32),
                TextField(
                  controller: _controller,
                  onChanged: _onChanged,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                  ),
                ),
                const SizedBox(height: 32),
                const NALHeaderText('LETRAS'),
                const SizedBox(height: 16),
                Text(
                  _result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 32),
                NALButton(label: 'COPIAR', onPressed: _copyToClipboard),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
