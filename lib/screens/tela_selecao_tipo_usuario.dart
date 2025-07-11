import 'package:flutter/material.dart';
import 'dialogos/dialogo_tipo_usuario.dart';

class TelaSelecaoTipoUsuario extends StatelessWidget {
  final void Function(TipoUsuario) onSelecionado;
  const TelaSelecaoTipoUsuario({Key? key, required this.onSelecionado})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo!')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecione seu tipo de usuário',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.admin_panel_settings),
                onPressed: () => onSelecionado(TipoUsuario.administrador),
                label: const Text('Sou administrador'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.person),
                onPressed: () => onSelecionado(TipoUsuario.padrao),
                label: const Text('Sou usuário padrão'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
