import 'package:flutter/material.dart';
import 'screens/tela_inicial.dart';
import 'screens/tela_adm.dart';
import 'screens/tela_usuario.dart';
import 'widgets/menu.dart';
import 'screens/tela_configuracoes.dart';
import 'screens/dialogos/dialogo_tipo_usuario.dart';
import 'screens/tela_selecao_tipo_usuario.dart';
import 'screens/tela_hist_locs.dart';
import 'package:provider/provider.dart';
import 'providers/conexao_provider.dart';
import 'styles.dart';

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
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            background: AppColors.backgroundLight,
            surface: AppColors.surfaceLight,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onBackground: AppColors.textPrimaryLight,
            onSurface: AppColors.textPrimaryLight,
            error: AppColors.error,
          ),
          scaffoldBackgroundColor: AppColors.backgroundLight,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          cardColor: AppColors.surfaceLight,
          textTheme: const TextTheme(
            titleLarge: AppTextStyles.titleLight,
            bodyMedium: AppTextStyles.bodyLight,
            bodySmall: AppTextStyles.captionLight,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            background: AppColors.backgroundDark,
            surface: AppColors.surfaceDark,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onBackground: AppColors.textPrimaryDark,
            onSurface: AppColors.textPrimaryDark,
            error: AppColors.error,
          ),
          scaffoldBackgroundColor: AppColors.backgroundDark,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          cardColor: AppColors.surfaceDark,
          textTheme: const TextTheme(
            titleLarge: AppTextStyles.titleDark,
            bodyMedium: AppTextStyles.bodyDark,
            bodySmall: AppTextStyles.captionDark,
          ),
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
