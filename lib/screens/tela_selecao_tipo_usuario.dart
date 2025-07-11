import 'package:flutter/material.dart';
import 'dialogos/dialogo_tipo_usuario.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';

class TelaSelecaoTipoUsuario extends StatelessWidget {
  final void Function(TipoUsuario) onSelecionado;
  const TelaSelecaoTipoUsuario({Key? key, required this.onSelecionado})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Bem-vindo!', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpaces.xl),
          child: CardPadrao(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Selecione seu tipo de usuário',
                  style: context.titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpaces.xl * 2),
                ElevatedButton.icon(
                  icon: const Icon(Icons.admin_panel_settings),
                  onPressed: () => onSelecionado(TipoUsuario.administrador),
                  label: const Text('Sou administrador'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    textStyle: context.bodyStyle,
                  ),
                ),
                const SizedBox(height: AppSpaces.xl),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  onPressed: () => onSelecionado(TipoUsuario.padrao),
                  label: const Text('Sou usuário padrão'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
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
    );
  }
}
