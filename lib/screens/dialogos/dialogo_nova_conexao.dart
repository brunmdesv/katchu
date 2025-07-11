import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogoNovaConexao extends StatefulWidget {
  const DialogoNovaConexao({Key? key}) : super(key: key);

  @override
  State<DialogoNovaConexao> createState() => _DialogoNovaConexaoState();
}

class _DialogoNovaConexaoState extends State<DialogoNovaConexao> {
  late String codigo;

  @override
  void initState() {
    super.initState();
    codigo = _gerarCodigo();
  }

  String _gerarCodigo() {
    final random = Random();
    return List.generate(4, (_) => random.nextInt(10).toString()).join();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova Conexão'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            codigo,
            style: const TextStyle(
              fontSize: 32,
              letterSpacing: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: codigo));
              Navigator.of(context).pop(codigo);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
