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
      body: FutureBuilder<List<Servicio>>(
        future: _servicios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay servicios disponibles."));
          }

          final servicios = snapshot.data!;

          return ListView.builder(
            itemCount: servicios.length,
            itemBuilder: (context, index) {
              final servicio = servicios[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(servicio.foto, height: 200, fit: BoxFit.cover),
                      SizedBox(height: 10),
                      Text(servicio.nombre,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                      SizedBox(height: 6),
                      Text(servicio.descripcion,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify),
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
