import 'package:flutter/material.dart';
import '../widgets/menu.dart';

class TelaInicial extends StatelessWidget {
  final Widget menu;
  const TelaInicial({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Painel de usuário',
            onPressed: () {
              Navigator.pushNamed(context, '/user');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adm');
              },
              child: const Text('Painel de administração'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: menu,
    );
  }
}
