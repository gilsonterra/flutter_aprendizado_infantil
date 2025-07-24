import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  final String nome;
  final String imagem;
  final VoidCallback onTap;
  final Gradient textColor;

  const CardButton({
    Key? key,
    required this.nome,
    required this.imagem,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  Color _color = Colors.transparent;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _color = Color.fromRGBO(186, 110, 63, 1);
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _color = Colors.transparent;
    });
  }

  void _onTapCancel() {
    setState(() {
      _color = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        color: _color,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: SizedBox(
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(23, 32, 15, 1.0),
                  width: 10,
                ),
                left: BorderSide(
                  color: Color.fromRGBO(23, 32, 15, 1.0),
                  width: 10,
                ),
                right: BorderSide(
                  color: Color.fromRGBO(105, 116, 99, 1.0),
                  width: 10,
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(105, 116, 99, 1.0),
                  width: 10,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    child: Image.asset(widget.imagem, fit: BoxFit.contain),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Text(
                    widget.nome.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.0,
                      color: Colors.deepOrangeAccent,
                      fontFamily: 'PressStart2P',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          color: Colors.black87,
                          blurRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
