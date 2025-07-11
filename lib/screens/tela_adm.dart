import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/conexao_provider.dart';
import 'dialogos/dialogo_nova_conexao.dart';
import '../widgets/card_padrao.dart';
import '../styles.dart';

class TelaAdm extends StatelessWidget {
  final Widget menu;
  const TelaAdm({Key? key, required this.menu}) : super(key: key);

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
        child: ListView(
          children: [
            if (conexao.codigo != null && conexao.dataHora != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpaces.xl,
                  vertical: 8,
                ),
                child: CardPadrao(
                  onTap: () => Navigator.pushNamed(context, '/historico'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: AppColors.success,
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
                          TextButton.icon(
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: conexao.codigo == null
          ? FloatingActionButton.extended(
              onPressed: () async {
                final codigo = await showDialog<String>(
                  context: context,
                  builder: (context) => const DialogoNovaConexao(),
                );
                if (codigo != null && codigo.length == 4) {
                  context.read<ConexaoProvider>().criarConexao(codigo);
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
