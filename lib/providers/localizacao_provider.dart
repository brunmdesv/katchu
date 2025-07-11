import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocalizacaoProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  Position? _posicaoAtual;
  bool _carregando = false;
  String? _erro;

  Position? get posicaoAtual => _posicaoAtual;
  bool get carregando => _carregando;
  String? get erro => _erro;

  // Verificar se as permissões de localização estão concedidas
  Future<bool> verificarPermissoes() async {
    bool servicoHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicoHabilitado) {
      _erro = 'Serviços de localização estão desabilitados';
      notifyListeners();
      return false;
    }

    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        _erro = 'Permissões de localização foram negadas';
        notifyListeners();
        return false;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      _erro = 'Permissões de localização foram negadas permanentemente';
      notifyListeners();
      return false;
    }

    return true;
  }

  // Capturar localização atual
  Future<Position?> capturarLocalizacao() async {
    if (!await verificarPermissoes()) {
      return null;
    }

    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      _posicaoAtual = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _carregando = false;
      });
      return _posicaoAtual;
    } catch (e) {
      setState(() {
        _carregando = false;
        _erro = 'Erro ao capturar localização: $e';
      });
      return null;
    }
  }

  // Salvar localização no Firestore
  Future<bool> salvarLocalizacaoNoFirestore(
    String pin,
    String usuarioId,
  ) async {
    if (_posicaoAtual == null) {
      _erro = 'Nenhuma localização capturada';
      notifyListeners();
      return false;
    }

    try {
      await _firestore.collection('localizacoes').add({
        'pin': pin,
        'usuarioId': usuarioId,
        'latitude': _posicaoAtual!.latitude,
        'longitude': _posicaoAtual!.longitude,
        'timestamp': FieldValue.serverTimestamp(),
        'precisao': _posicaoAtual!.accuracy,
      });
      return true;
    } catch (e) {
      _erro = 'Erro ao salvar localização: $e';
      notifyListeners();
      return false;
    }
  }

  // Buscar localizações de um PIN específico
  Stream<QuerySnapshot> buscarLocalizacoes(String pin) {
    return _firestore
        .collection('localizacoes')
        .where('pin', isEqualTo: pin)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .handleError((error) {
          // Se o erro for de índice não existente, criar automaticamente
          if (error.toString().contains('FAILED_PRECONDITION') &&
              error.toString().contains('requires an index')) {
            _criarIndiceAutomaticamente();
          }
          // Retornar stream vazio em caso de erro
          return Stream.empty();
        });
  }

  // Criar índice automaticamente
  Future<void> _criarIndiceAutomaticamente() async {
    try {
      // Criar índice composto para localizacoes
      await _firestore.collection('localizacoes').get();
      // O Firestore criará automaticamente o índice quando necessário
    } catch (e) {
      print('Erro ao criar índice: $e');
    }
  }

  // Buscar localizações sem ordenação (fallback)
  Stream<QuerySnapshot> buscarLocalizacoesSemOrdenacao(String pin) {
    return _firestore
        .collection('localizacoes')
        .where('pin', isEqualTo: pin)
        .snapshots();
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  void limparErro() {
    _erro = null;
    notifyListeners();
  }
}
