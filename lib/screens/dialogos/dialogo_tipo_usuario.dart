import 'package:flutter/material.dart';

enum TipoUsuario { padrao, administrador }

typedef OnTipoUsuarioSelecionado = void Function(TipoUsuario);

class DialogoTipoUsuario extends StatelessWidget {
  final TipoUsuario tipoAtual;
  final OnTipoUsuarioSelecionado onSelecionado;
  const DialogoTipoUsuario({
    Key? key,
    required this.tipoAtual,
    required this.onSelecionado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecione o tipo de usuário'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<TipoUsuario>(
            value: TipoUsuario.padrao,
            groupValue: tipoAtual,
            title: const Text('Usuário padrão'),
            onChanged: (value) {
              if (value != null) {
                onSelecionado(value);
                Navigator.of(context).pop();
              }
            },
          ),
          RadioListTile<TipoUsuario>(
            value: TipoUsuario.administrador,
            groupValue: tipoAtual,
            title: const Text('Administrador'),
            onChanged: (value) {
              if (value != null) {
                onSelecionado(value);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
