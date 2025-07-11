import 'package:flutter/material.dart';
import 'screens/tela_inicial.dart';
import 'screens/tela_adm.dart';
import 'screens/tela_usuario.dart';
import 'widgets/menu.dart';
import 'screens/tela_configuracoes.dart';
import 'screens/dialogos/dialogo_tipo_usuario.dart';
import 'screens/tela_selecao_tipo_usuario.dart';
import 'screens/historico_conexoes.dart';
import 'package:provider/provider.dart';
import 'screens/conexao_provider.dart';

typedef OnTemaSelecionado = void Function(ThemeMode);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  TipoUsuario? _tipoUsuario;

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void _setTipoUsuario(TipoUsuario tipo) {
    setState(() {
      _tipoUsuario = tipo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConexaoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          brightness: Brightness.dark,
        ),
        themeMode: _themeMode,
        initialRoute: '/',
        routes: {
          '/': (context) {
            if (_tipoUsuario == null) {
              return TelaSelecaoTipoUsuario(onSelecionado: _setTipoUsuario);
            } else if (_tipoUsuario == TipoUsuario.administrador) {
              return TelaAdm(menu: _buildMenu(context));
            } else {
              return TelaUser(menu: _buildMenu(context));
            }
          },
          '/adm': (context) => TelaAdm(menu: _buildMenu(context)),
          '/user': (context) => TelaUser(menu: _buildMenu(context)),
          '/configuracoes': (context) => TelaConfiguracoes(
            themeMode: _themeMode,
            onThemeChanged: _setThemeMode,
            menu: _buildMenu(context),
            tipoUsuario: _tipoUsuario!,
            onTipoUsuarioChanged: _setTipoUsuario,
          ),
          '/historico': (context) =>
              HistoricoConexoes(menu: _buildMenu(context)),
        },
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return MenuInferior(
      onConfigPressed: () {
        Navigator.pushNamed(context, '/configuracoes');
      },
      onHomePressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );
  }
}
