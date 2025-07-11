import 'package:flutter/material.dart';
import 'dialogos/dialogo_nova_conexao.dart';

class TelaAdm extends StatefulWidget {
  final Widget menu;
  const TelaAdm({Key? key, required this.menu}) : super(key: key);

  @override
  State<TelaAdm> createState() => _TelaAdmState();
}

class _TelaAdmState extends State<TelaAdm> {
  String? _codigoConexao;
  DateTime? _dataConexao;

  void _criarConexao() async {
    final codigo = await showDialog<String>(
      context: context,
      builder: (context) => const DialogoNovaConexao(),
    );
    if (codigo != null && codigo.length == 4) {
      setState(() {
        _codigoConexao = codigo;
        _dataConexao = DateTime.now();
      });
    }
  }

  void _desconectar() {
    setState(() {
      _codigoConexao = null;
      _dataConexao = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painel de Administração')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Bem-vindo ao Painel de Administração!')),
          const SizedBox(height: 32),
          if (_codigoConexao != null && _dataConexao != null) ...[
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.pushNamed(context, '/historico');
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _codigoConexao!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                letterSpacing: 8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${_dataConexao!.day.toString().padLeft(2, '0')}/'
                              '${_dataConexao!.month.toString().padLeft(2, '0')}/'
                              '${_dataConexao!.year} '
                              '${_dataConexao!.hour.toString().padLeft(2, '0')}:'
                              '${_dataConexao!.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: _desconectar,
                              icon: const Icon(
                                Icons.link_off,
                                size: 16,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'Desconectar',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: _codigoConexao == null
          ? FloatingActionButton.extended(
              onPressed: _criarConexao,
              icon: const Icon(Icons.add),
              label: const Text('Criar conexão'),
            )
          : null,
      bottomNavigationBar: widget.menu,
    );
  }
}
