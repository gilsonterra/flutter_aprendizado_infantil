import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello_flutter/features/animais/presentation/pages/animals_page.dart';
import 'package:hello_flutter/features/animais/presentation/pages/numbers_page.dart';
import 'package:shake/shake.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../../../core/tts/tts_service.dart';
import '../../../animais/data/animais_data.dart';
import '../../../../shared/gradients.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TTSService ttsService = TTSService();
  late ShakeDetector shakeDetector;

  int gradienteAtual = 0;
  int _paginaAtual = 0;

  @override
  void initState() {
    super.initState();

    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        setState(() {
          listaAnimais.shuffle(Random());

          int novoGradiente;
          do {
            novoGradiente = Random().nextInt(gradientes.length);
          } while (novoGradiente == gradienteAtual);
          gradienteAtual = novoGradiente;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Animais embaralhados e fundo alterado!'),
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  Future<void> falarAnimal(String nome) async {
    try {
      await ttsService.falar(nome);
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Animal: $nome')));
    }
  }

  final List<IconData> _icones = [Icons.pets, Icons.looks_two_rounded];

  final List<Widget> pages = [AnimalsPage(), NumbersPage()];

  void _navegar(BuildContext context, String destino) {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navegando para: $destino')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_paginaAtual],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icones,
        activeIndex: _paginaAtual,
        elevation: 0,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => setState(() => _paginaAtual = index),
        activeColor: Colors.white,
        splashColor: Colors.lightGreenAccent.shade200,
        inactiveColor: Colors.white70,
        backgroundColor: Colors.transparent,
        iconSize: 40,
      ),
    );
  }
}
