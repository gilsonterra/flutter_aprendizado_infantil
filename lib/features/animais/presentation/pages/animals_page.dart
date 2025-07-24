import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import '../../../../core/tts/tts_service.dart';
import '../../../animais/data/animais_data.dart';
import '../../../animais/presentation/widgets/card_button.dart';
import '../../../../shared/gradients.dart';

class AnimalsPage extends StatefulWidget {
  @override
  _AnimalsPageState createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  final TTSService ttsService = TTSService();
  late ShakeDetector shakeDetector;

  int gradienteAtual = 0;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradientes[gradienteAtual]),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Animais 🐾',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: listaAnimais.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final animal = listaAnimais[index];
                  return CardButton(
                    nome: animal.nome,
                    imagem: animal.imagem,
                    textColor: gradientes[gradienteAtual],
                    onTap: () => falarAnimal(animal.nome),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
