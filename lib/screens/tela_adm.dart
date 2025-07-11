import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/conexao_provider.dart';
import 'dialogos/dialogo_nova_conexao.dart';
import '../widgets/card_padrao.dart';
import '../styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaAdm extends StatelessWidget {
  final Widget menu;
  const TelaAdm({Key? key, required this.menu}) : super(key: key);

  Future<bool> _usuarioConectado(String? pin) async {
    if (pin == null) return false;
    final doc = await FirebaseFirestore.instance
        .collection('conexoes')
        .doc(pin)
        .get();
    return doc.exists && doc['usuarioPadraoId'] != null;
  }

  @override
  Widget build(BuildContext context) {
    final conexao = context.watch<ConexaoProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Painel de Administração', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpaces.xl),
        child: FutureBuilder<bool>(
          future: _usuarioConectado(conexao.codigo),
          builder: (context, snapshot) {
            if (conexao.codigo == null || conexao.dataHora == null) {
              return const SizedBox.shrink();
            }
            final conectado = snapshot.data == true;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpaces.xl,
                vertical: 8,
              ),
              child: CardPadrao(
                onTap: conectado
                    ? () => Navigator.pushNamed(context, '/historico')
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: conectado
                                ? AppColors.success
                                : AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Spacer(),
                        Text(conexao.codigo!, style: context.codeStyle),
                      ],
                    ),
                    const SizedBox(height: AppSpaces.xl),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.textSecondaryLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${conexao.dataHora!.day.toString().padLeft(2, '0')}/'
                          '${conexao.dataHora!.month.toString().padLeft(2, '0')}/'
                          '${conexao.dataHora!.year} '
                          '${conexao.dataHora!.hour.toString().padLeft(2, '0')}:'
                          '${conexao.dataHora!.minute.toString().padLeft(2, '0')}',
                          style: context.captionStyle,
                        ),
                        const Spacer(),
                        conectado
                            ? TextButton.icon(
                                onPressed: () => conexao.desconectar(),
                                icon: const Icon(
                                  Icons.link_off,
                                  size: 16,
                                  color: AppColors.error,
                                ),
                                label: const Text(
                                  'Desconectar',
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 13,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                            : TextButton.icon(
                                onPressed: null,
                                icon: const Icon(
                                  Icons.hourglass_empty,
                                  size: 16,
                                  color: AppColors.error,
                                ),
                                label: const Text(
                                  'Aguardando...',
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 13,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: conexao.codigo == null
          ? FloatingActionButton.extended(
              onPressed: () async {
                final admId = 'adm_demo';
                await context.read<ConexaoProvider>().criarConexaoFirestore(
                  admId,
                );
                final pin = context.read<ConexaoProvider>().codigo;
                if (pin != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('PIN gerado'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            pin,
                            style: const TextStyle(
                              fontSize: 32,
                              letterSpacing: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Criar conexão'),
              backgroundColor: context.primaryColor,
            )
          : null,
      bottomNavigationBar: menu,
    );
  }
}
