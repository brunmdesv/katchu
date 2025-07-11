import 'package:flutter/material.dart';
import 'dialogos/dialogo_tema.dart';
import 'dialogos/dialogo_tipo_usuario.dart';

typedef OnTemaSelecionado = void Function(ThemeMode);

typedef OnTipoUsuarioChanged = void Function(TipoUsuario);

class TelaConfiguracoes extends StatefulWidget {
  final ThemeMode themeMode;
  final OnTemaSelecionado onThemeChanged;
  final Widget menu;
  final TipoUsuario tipoUsuario;
  final OnTipoUsuarioChanged onTipoUsuarioChanged;
  const TelaConfiguracoes({
    Key? key,
    required this.themeMode,
    required this.onThemeChanged,
    required this.menu,
    required this.tipoUsuario,
    required this.onTipoUsuarioChanged,
  }) : super(key: key);

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  late TipoUsuario _tipoUsuario;

  @override
  void initState() {
    super.initState();
    _tipoUsuario = widget.tipoUsuario;
  }

  void _selecionarTipoUsuario() {
    showDialog(
      context: context,
      builder: (context) => DialogoTipoUsuario(
        tipoAtual: _tipoUsuario,
        onSelecionado: (tipo) {
          setState(() {
            _tipoUsuario = tipo;
          });
          widget.onTipoUsuarioChanged(tipo);
          Navigator.of(context).pop(); // Fecha a tela de configurações
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Muda tema'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DialogoTema(
                  temaAtual: widget.themeMode,
                  onTemaSelecionado: widget.onThemeChanged,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Tipo de usuário'),
            subtitle: Text(
              _tipoUsuario == TipoUsuario.padrao
                  ? 'Usuário padrão'
                  : 'Administrador',
            ),
            onTap: _selecionarTipoUsuario,
          ),
        ],
      ),
      bottomNavigationBar: widget.menu,
    );
  }
}
