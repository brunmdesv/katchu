import 'package:flutter/material.dart';

class HistoricoConexoes extends StatelessWidget {
  final Widget menu;
  const HistoricoConexoes({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de conexões')),
      body: const Center(child: Text('Nenhum histórico disponível ainda.')),
      bottomNavigationBar: menu,
    );
  }
}
