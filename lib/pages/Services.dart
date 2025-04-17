import 'package:final_proyect/Models/ModelsServices.dart';
import 'package:flutter/material.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  late Future<List<Servicio>> _servicios;

  @override
  void initState() {
    super.initState();
    _servicios = fetchServicios();
  }

  Future<List<Servicio>> fetchServicios() async {
    final url = Uri.parse('https://adamix.net/defensa_civil/def/servicios.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData['exito'] == true) {
        final List datos = jsonData['datos'];
        return datos.map((item) => Servicio.fromJson(item)).toList();
      } else {
        throw Exception('No se pudo cargar los servicios');
      }
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Servicios',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[700],
        elevation: 0,
      ),
      body: FutureBuilder<List<Servicio>>(
        future: _servicios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar los servicios",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[700],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No hay servicios disponibles",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final servicios = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: servicios.length,
            itemBuilder: (context, index) {
              final servicio = servicios[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          servicio.foto,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        servicio.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        servicio.descripcion,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
