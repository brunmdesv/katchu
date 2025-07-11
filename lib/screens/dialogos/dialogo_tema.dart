import 'package:flutter/material.dart';

typedef OnTemaSelecionado = void Function(ThemeMode);

class DialogoTema extends StatelessWidget {
  final ThemeMode temaAtual;
  final OnTemaSelecionado onTemaSelecionado;
  const DialogoTema({
    Key? key,
    required this.temaAtual,
    required this.onTemaSelecionado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Escolha o tema'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            groupValue: temaAtual,
            title: const Text('Tema Claro'),
            onChanged: (value) {
              if (value != null) {
                onTemaSelecionado(value);
                Navigator.of(context).pop();
              }
            },
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            groupValue: temaAtual,
            title: const Text('Tema Escuro'),
            onChanged: (value) {
              if (value != null) {
                onTemaSelecionado(value);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
