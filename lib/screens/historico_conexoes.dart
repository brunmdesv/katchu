import 'package:flutter/material.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';

class HistoricoConexoes extends StatelessWidget {
  final Widget menu;
  const HistoricoConexoes({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Histórico de conexões', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpaces.xl,
          vertical: AppSpaces.xl,
        ),
        child: CardPadrao(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.history, size: 48, color: AppColors.secondary),
              const SizedBox(height: AppSpaces.xl),
              Text(
                'Nenhum histórico disponível ainda.',
                style: context.bodyStyle,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: menu,
    );
  }
}
