import 'package:flutter/material.dart';

class MenuInferior extends StatelessWidget {
  final VoidCallback onConfigPressed;
  final VoidCallback onHomePressed;
  const MenuInferior({
    Key? key,
    required this.onConfigPressed,
    required this.onHomePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: onHomePressed,
            tooltip: 'Início',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: onConfigPressed,
            tooltip: 'Configurações',
          ),
        ],
      ),
    );
  }
}
