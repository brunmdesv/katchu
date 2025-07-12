import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../styles.dart';
import '../widgets/card_padrao.dart';

class TelaDetalhesLoc extends StatefulWidget {
  final String localizacaoId;
  final Widget menu;

  const TelaDetalhesLoc({
    Key? key,
    required this.localizacaoId,
    required this.menu,
  }) : super(key: key);

  @override
  State<TelaDetalhesLoc> createState() => _TelaDetalhesLocState();
}

class _TelaDetalhesLocState extends State<TelaDetalhesLoc> {
  GoogleMapController? _mapController;
  Map<String, dynamic>? _localizacao;
  bool _carregando = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregarLocalizacao();
  }

  Future<void> _carregarLocalizacao() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('localizacoes')
          .doc(widget.localizacaoId)
          .get();

      if (doc.exists) {
        setState(() {
          _localizacao = doc.data() as Map<String, dynamic>;
          _carregando = false;
        });
      } else {
        setState(() {
          _erro = 'Localização não encontrada';
          _carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro ao carregar localização: $e';
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Detalhes da Localização', style: context.titleStyle),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 48, color: AppColors.error),
                  const SizedBox(height: AppSpaces.lg),
                  Text(_erro!, style: context.bodyStyle),
                ],
              ),
            )
          : _localizacao != null
          ? Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(AppSpaces.lg),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _localizacao!['latitude'],
                            _localizacao!['longitude'],
                          ),
                          zoom: 15.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId('localizacao'),
                            position: LatLng(
                              _localizacao!['latitude'],
                              _localizacao!['longitude'],
                            ),
                            infoWindow: InfoWindow(
                              title: 'Localização Capturada',
                              snippet:
                                  'Precisão: ±${(_localizacao!['precisao'] ?? 0).toStringAsFixed(1)}m',
                            ),
                          ),
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpaces.lg),
                    child: CardPadrao(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSpaces.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: AppSpaces.sm),
                                Text('Coordenadas', style: context.titleStyle),
                              ],
                            ),
                            const SizedBox(height: AppSpaces.md),
                            _buildInfoRow(
                              'Latitude',
                              '${_localizacao!['latitude'].toStringAsFixed(6)}',
                            ),
                            _buildInfoRow(
                              'Longitude',
                              '${_localizacao!['longitude'].toStringAsFixed(6)}',
                            ),
                            _buildInfoRow(
                              'Precisão',
                              '±${(_localizacao!['precisao'] ?? 0).toStringAsFixed(1)}m',
                            ),
                            if (_localizacao!['timestamp'] != null)
                              _buildInfoRow(
                                'Data/Hora',
                                _formatarTimestamp(_localizacao!['timestamp']),
                              ),
                            if (_localizacao!['usuarioId'] != null)
                              _buildInfoRow(
                                'Usuário',
                                _localizacao!['usuarioId'],
                              ),
                            if (_localizacao!['pin'] != null)
                              _buildInfoRow('PIN', _localizacao!['pin']),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: Text('Nenhuma localização disponível')),
      bottomNavigationBar: widget.menu,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: context.captionStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value, style: context.bodyStyle)),
        ],
      ),
    );
  }

  String _formatarTimestamp(Timestamp timestamp) {
    final data = timestamp.toDate();
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year} '
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';
  }
}
