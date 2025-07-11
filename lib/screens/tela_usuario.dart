import 'package:flutter/material.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Painel de Usuário', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpaces.xl),
          child: CardPadrao(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica para ativar permissões
                  },
                  icon: const Icon(Icons.lock_open),
                  label: const Text('Ativar permissões'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(44),
                    textStyle: context.bodyStyle,
                  ),
                ),
                const SizedBox(height: AppSpaces.xl),
                if (_codigoConectado == null) ...[
                  TextField(
                    controller: _codigoController,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Código (4 dígitos)',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                    style: context.bodyStyle,
                  ),
                  const SizedBox(height: AppSpaces.xl),
                  ElevatedButton(
                    onPressed: _conectar,
                    child: const Text('Conectar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(44),
                      textStyle: context.bodyStyle,
                    ),
                  ),
                ] else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text('Conectado ao código ', style: context.bodyStyle),
                      Text(_codigoConectado!, style: context.codeStyle),
                    ],
                  ),
                  const SizedBox(height: AppSpaces.xl),
                  ElevatedButton(
                    onPressed: _desconectar,
                    child: const Text('Desconectar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(44),
                      textStyle: context.bodyStyle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.menu,
    );
  }
}
