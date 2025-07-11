import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';

class TelaInicial extends StatelessWidget {
  final Widget menu;
  const TelaInicial({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Tela Inicial', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpaces.xl),
          child: CardPadrao(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Bem-vindo!', style: context.titleStyle),
                const SizedBox(height: AppSpaces.xl),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/adm');
                  },
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text('Painel de administração'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    textStyle: context.bodyStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: menu,
    );
  }
}
