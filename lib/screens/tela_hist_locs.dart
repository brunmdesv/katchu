import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';
import '../providers/conexao_provider.dart';
import '../providers/localizacao_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricoLocalizacoes extends StatelessWidget {
  final Widget menu;
  const HistoricoLocalizacoes({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conexao = context.watch<ConexaoProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Histórico de Localização', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpaces.xl,
          vertical: AppSpaces.xl,
        ),
        child: Column(
          children: [
            if (conexao.codigo != null) ...[
              CardPadrao(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpaces.lg),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.primary),
                          const SizedBox(width: AppSpaces.sm),
                          Text(
                            'Conexão ativa: ${conexao.codigo}',
                            style: context.bodyStyle,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpaces.lg),
                      ElevatedButton.icon(
                        onPressed: () => _capturarLocalizacaoUsuario(context),
                        icon: const Icon(Icons.my_location),
                        label: const Text('Capturar localização do usuário'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpaces.lg),
            ],
            Expanded(
              child: conexao.codigo != null
                  ? StreamBuilder<QuerySnapshot>(
                      stream: context
                          .read<LocalizacaoProvider>()
                          .buscarLocalizacoes(conexao.codigo!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          // Se erro de índice, tentar sem ordenação
                          if (snapshot.error.toString().contains(
                            'FAILED_PRECONDITION',
                          )) {
                            return StreamBuilder<QuerySnapshot>(
                              stream: context
                                  .read<LocalizacaoProvider>()
                                  .buscarLocalizacoesSemOrdenacao(
                                    conexao.codigo!,
                                  ),
                              builder: (context, fallbackSnapshot) {
                                if (fallbackSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (fallbackSnapshot.hasError) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.error,
                                          size: 48,
                                          color: AppColors.error,
                                        ),
                                        const SizedBox(height: AppSpaces.lg),
                                        Text(
                                          'Erro ao carregar localizações',
                                          style: context.bodyStyle,
                                        ),
                                        const SizedBox(height: AppSpaces.sm),
                                        Text(
                                          'Índice em construção. Tente novamente em alguns minutos.',
                                          style: context.captionStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return _construirListaLocalizacoes(
                                  context,
                                  fallbackSnapshot.data?.docs ?? [],
                                );
                              },
                            );
                          }

                          return Center(
                            child: Text(
                              'Erro ao carregar localizações: ${snapshot.error}',
                            ),
                          );
                        }

                        return _construirListaLocalizacoes(
                          context,
                          snapshot.data?.docs ?? [],
                        );
                      },
                    )
                  : CardPadrao(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_off,
                            size: 48,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(height: AppSpaces.lg),
                          Text(
                            'Nenhuma conexão ativa.',
                            style: context.bodyStyle,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: menu,
    );
  }

  Future<void> _capturarLocalizacaoUsuario(BuildContext context) async {
    final localizacaoProvider = context.read<LocalizacaoProvider>();
    final conexao = context.read<ConexaoProvider>();

    if (conexao.codigo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nenhuma conexão ativa')));
      return;
    }

    final posicao = await localizacaoProvider.capturarLocalizacao();
    if (posicao != null) {
      final sucesso = await localizacaoProvider.salvarLocalizacaoNoFirestore(
        conexao.codigo!,
        conexao.usuarioPadraoId ?? 'usuario_desconhecido',
      );

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Localização capturada e salva!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              localizacaoProvider.erro ?? 'Erro ao salvar localização',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizacaoProvider.erro ?? 'Erro ao capturar localização',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _construirListaLocalizacoes(
    BuildContext context,
    List<QueryDocumentSnapshot> localizacoes,
  ) {
    if (localizacoes.isEmpty) {
      return CardPadrao(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off, size: 48, color: AppColors.secondary),
            const SizedBox(height: AppSpaces.lg),
            Text(
              'Nenhuma localização capturada ainda.',
              style: context.bodyStyle,
            ),
          ],
        ),
      );
    }

    // Ordenar localizações por timestamp (mais recente primeiro)
    localizacoes.sort((a, b) {
      final aData = a.data() as Map<String, dynamic>;
      final bData = b.data() as Map<String, dynamic>;
      final aTimestamp = aData['timestamp'] as Timestamp?;
      final bTimestamp = bData['timestamp'] as Timestamp?;

      if (aTimestamp == null && bTimestamp == null) return 0;
      if (aTimestamp == null) return 1;
      if (bTimestamp == null) return -1;

      return bTimestamp.compareTo(aTimestamp);
    });

    return ListView.builder(
      itemCount: localizacoes.length,
      itemBuilder: (context, index) {
        final localizacao = localizacoes[index].data() as Map<String, dynamic>;
        final timestamp = localizacao['timestamp'] as Timestamp?;

        return CardPadrao(
          child: ListTile(
            leading: Icon(Icons.location_on, color: AppColors.primary),
            title: Text(
              'Lat: ${localizacao['latitude'].toStringAsFixed(6)}, '
              'Lng: ${localizacao['longitude'].toStringAsFixed(6)}',
              style: context.bodyStyle,
            ),
            subtitle: timestamp != null
                ? Text(
                    '${timestamp.toDate().day.toString().padLeft(2, '0')}/'
                    '${timestamp.toDate().month.toString().padLeft(2, '0')}/'
                    '${timestamp.toDate().year} '
                    '${timestamp.toDate().hour.toString().padLeft(2, '0')}:'
                    '${timestamp.toDate().minute.toString().padLeft(2, '0')}',
                    style: context.captionStyle,
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '±${(localizacao['precisao'] ?? 0).toStringAsFixed(1)}m',
                  style: context.captionStyle,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondaryLight,
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detalhes-localizacao',
                arguments: {'localizacaoId': localizacoes[index].id},
              );
            },
          ),
        );
      },
    );
  }
}
