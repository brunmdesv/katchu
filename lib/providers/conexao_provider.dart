import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conexao {
  final String pin;
  final String admId;
  final String? usuarioPadraoId;
  final DateTime timestamp;

  Conexao({
    required this.pin,
    required this.admId,
    this.usuarioPadraoId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'pin': pin,
      'admId': admId,
      'usuarioPadraoId': usuarioPadraoId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Conexao.fromMap(Map<String, dynamic> map) {
    return Conexao(
      pin: map['pin'],
      admId: map['admId'],
      usuarioPadraoId: map['usuarioPadraoId'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class ConexaoProvider extends ChangeNotifier {
  String? _codigo;
  DateTime? _dataHora;
  String? _admId;
  String? _usuarioPadraoId;

  String? get codigo => _codigo;
  DateTime? get dataHora => _dataHora;
  String? get admId => _admId;
  String? get usuarioPadraoId => _usuarioPadraoId;

  final _firestore = FirebaseFirestore.instance;

  Future<void> criarConexaoFirestore(String admId) async {
    // Gera um PIN único de 4 dígitos
    String pin = await _gerarPinUnico();
    final agora = DateTime.now();
    final conexao = Conexao(
      pin: pin,
      admId: admId,
      usuarioPadraoId: null,
      timestamp: agora,
    );
    await _firestore.collection('conexoes').doc(pin).set(conexao.toMap());
    _codigo = pin;
    _dataHora = agora;
    _admId = admId;
    _usuarioPadraoId = null;
    notifyListeners();
  }

  Future<String> _gerarPinUnico() async {
    String pin;
    bool existe = true;
    do {
      pin = List.generate(
        4,
        (_) => (DateTime.now().millisecondsSinceEpoch % 10).toString(),
      ).join();
      final doc = await _firestore.collection('conexoes').doc(pin).get();
      existe = doc.exists;
    } while (existe);
    return pin;
  }

  Future<bool> conectarComoUsuarioPadrao(
    String pin,
    String usuarioPadraoId,
  ) async {
    final doc = await _firestore.collection('conexoes').doc(pin).get();
    if (!doc.exists) return false;
    await _firestore.collection('conexoes').doc(pin).update({
      'usuarioPadraoId': usuarioPadraoId,
    });
    _codigo = pin;
    _dataHora = DateTime.parse(doc['timestamp']);
    _admId = doc['admId'];
    _usuarioPadraoId = usuarioPadraoId;
    notifyListeners();
    return true;
  }

  void desconectar() {
    _codigo = null;
    _dataHora = null;
    _admId = null;
    _usuarioPadraoId = null;
    notifyListeners();
  }
}
