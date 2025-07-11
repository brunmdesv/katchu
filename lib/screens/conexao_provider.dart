import 'package:flutter/material.dart';

class ConexaoProvider extends ChangeNotifier {
  String? _codigo;
  DateTime? _dataHora;

  String? get codigo => _codigo;
  DateTime? get dataHora => _dataHora;

  void criarConexao(String codigo) {
    _codigo = codigo;
    _dataHora = DateTime.now();
    notifyListeners();
  }

  void desconectar() {
    _codigo = null;
    _dataHora = null;
    notifyListeners();
  }
}
