import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Measures extends StatefulWidget {
  @override
  _MeasuresState createState() => _MeasuresState();
}

class _MeasuresState extends State<Measures> {
  List<dynamic> _medidas = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchMedidas();
  }

  Future<void> _fetchMedidas() async {
    final url = Uri.parse(
        'https://adamix.net/defensa_civil/def/medidas_preventivas.php');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['exito'] == true) {
          setState(() {
            _medidas = data['datos'];
            _isLoading = false;
          });
        } else {
          throw Exception(data['mensaje'] ?? 'Error al cargar datos');
        }
      } else {
        throw Exception('Error de conexión: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _errorMessage = 'No se pudieron cargar las medidas preventivas';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700], // Fondo más claro para mejor contraste
      appBar: AppBar(
        title: const Text(
          'Medidas Preventivas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(

          size: 29
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchMedidas,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
              ),
              child: const Text('Reintentar',
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }

    if (_medidas.isEmpty) {
      return const Center(
        child: Text(
          'No hay medidas preventivas disponibles',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _medidas.length,
      itemBuilder: (context, index) {
        final medida = _medidas[index];
        return _buildMeasureCard(medida);
      },
    );
  }

  Widget _buildMeasureCard(Map<String, dynamic> medida) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showMeasureDetail(medida),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (medida['foto'] != null &&
                  medida['foto'].toString().isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    medida['foto'],
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.broken_image,
                            size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                medida['titulo'] ?? 'Sin título',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[800],
                ),
              ),
              const SizedBox(height: 8),
              if (medida['descripcion'] != null &&
                  medida['descripcion'].toString().isNotEmpty)
                Text(
                  'Toque para ver detalles',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
/*
  void _showMeasureDetail(Map<String, dynamic> medida) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          medida['titulo'] ?? 'Medida Preventiva',
          style: const TextStyle(color: Colors.amber),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (medida['foto'] != null &&
                  medida['foto'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      medida['foto'],
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Text(
                medida['descripcion'] ?? 'No hay descripción disponible',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cerrar',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }*/


void _showMeasureDetail(Map<String, dynamic> medida) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        medida['titulo']?.toString() ?? 'Medida Preventiva',
        style: TextStyle(color: Colors.amber[700]),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (medida['foto'] != null && medida['foto'].toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    medida['foto'].toString(),
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            Text(
              medida['descripcion']?.toString() ?? 'No hay descripción disponible',
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cerrar',
            style: TextStyle(color: Colors.amber[700]),
          ),
        ),
      ],
    ),
  );
}
}
