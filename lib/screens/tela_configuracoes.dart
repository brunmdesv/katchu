import 'package:flutter/material.dart';
import 'dialogos/dialogo_tema.dart';
import 'dialogos/dialogo_tipo_usuario.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';

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
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Configurações', style: context.titleStyle),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.brightness_6, color: AppColors.secondary),
                title: Text('Muda tema', style: context.bodyStyle),
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
              const Divider(),
              ListTile(
                leading: Icon(Icons.person, color: context.primaryColor),
                title: Text('Tipo de usuário', style: context.bodyStyle),
                subtitle: Text(
                  _tipoUsuario == TipoUsuario.padrao
                      ? 'Usuário padrão'
                      : 'Administrador',
                  style: context.captionStyle,
                ),
                onTap: _selecionarTipoUsuario,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.menu,
    );
  }
}
