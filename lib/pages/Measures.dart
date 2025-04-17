import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Measures extends StatefulWidget {

  @override
  _MeasuresState createState() => _MeasuresState();
}

class _MeasuresState extends State<Measures> {
  List<dynamic> medidas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMedidas();
  }

  Future<void> fetchMedidas() async {
    final url = Uri.parse('https://adamix.net/defensa_civil/def/medidas_preventivas.php');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          medidas = data['datos'];
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar datos');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      appBar: AppBar(
        title: Text('Medidas Preventivas'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: medidas.length,
        itemBuilder: (context, index) {
          final medida = medidas[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(medida['titulo']),
                    content: SingleChildScrollView(
                      child: Text(
                        medida['descripcion'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16),
                      )
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (medida['foto'] != null && medida['foto'].toString().isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          medida['foto'],
                          width: double.infinity,
                          height: 265,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                        ),
                      ),
                    SizedBox(height: 12),
                    Text(
                      medida['titulo'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}