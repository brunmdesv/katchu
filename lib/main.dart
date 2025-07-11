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
import 'providers/localizacao_provider.dart';
import 'styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OnTemaSelecionado = void Function(ThemeMode);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  TipoUsuario? _tipoUsuario;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  Future<void> _carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    final tema = prefs.getString('tema') ?? 'escuro';
    final tipo = prefs.getString('tipoUsuario');
    setState(() {
      _themeMode = tema == 'claro' ? ThemeMode.light : ThemeMode.dark;
      if (tipo == 'adm') {
        _tipoUsuario = TipoUsuario.administrador;
      } else if (tipo == 'padrao') {
        _tipoUsuario = TipoUsuario.padrao;
      }
    });
  }

  void _setThemeMode(ThemeMode mode) async {
    setState(() {
      _themeMode = mode;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tema', mode == ThemeMode.light ? 'claro' : 'escuro');
  }

  void _setTipoUsuario(TipoUsuario tipo) async {
    setState(() {
      _tipoUsuario = tipo;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'tipoUsuario',
      tipo == TipoUsuario.administrador ? 'adm' : 'padrao',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConexaoProvider()),
        ChangeNotifierProvider(create: (_) => LocalizacaoProvider()),
      ],
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
              return TelaSelecaoTipoUsuario(
                onSelecionado: (tipo) {
                  _setTipoUsuario(tipo);
                  // Após selecionar, força rebuild para não mostrar mais a tela de seleção
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {});
                  });
                },
              );
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
              HistoricoLocalizacoes(menu: _buildMenu(context)),
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
