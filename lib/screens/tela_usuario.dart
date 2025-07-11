import 'package:flutter/material.dart';

class TelaUser extends StatefulWidget {
  final Widget menu;
  const TelaUser({Key? key, required this.menu}) : super(key: key);

  @override
  State<TelaUser> createState() => _TelaUserState();
}

class _TelaUserState extends State<TelaUser> {
  final TextEditingController _codigoController = TextEditingController();
  String? _codigoConectado;

  @override
  void dispose() {
    _codigoController.dispose();
    super.dispose();
  }

  void _conectar() {
    final codigo = _codigoController.text;
    if (codigo.length == 4) {
      setState(() {
        _codigoConectado = codigo;
      });
    }
  }

  void _desconectar() {
    setState(() {
      _codigoConectado = null;
      _codigoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painel de Usuário')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Lógica para ativar permissões
                },
                child: const Text('Ativar permissões'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 32),
              if (_codigoConectado == null) ...[
                TextField(
                  controller: _codigoController,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Código (4 dígitos)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _conectar,
                  child: const Text('Conectar'),
                ),
              ] else ...[
                Text(
                  'Conectado ao código $_codigoConectado',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _desconectar,
                  child: const Text('Desconectar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.menu,
    );
  }
}
