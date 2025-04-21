import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaAlberguesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa de Albergues',
      home: MapaAlbergues(),
    );
  }
}

class MapaAlbergues extends StatefulWidget {
  @override
  _MapaAlberguesState createState() => _MapaAlberguesState();
}

class _MapaAlberguesState extends State<MapaAlbergues> {
  List<dynamic> albergues = [];

  void _mostrarListaAlbergues() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que el modal ocupe más espacio
      builder: (context) {
        return Container(
          color: Colors.amber[700],
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.8, // 80% de la pantalla
          child: Column(
            children: [
              const Text(
                'Lista de Albergues',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: albergues.length,
                  itemBuilder: (context, index) {
                    final albergue = albergues[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.amber),
                        title: Text(
                          albergue['edificio'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ciudad: ${albergue['ciudad']}'),
                            Text('Capacidad: ${albergue['capacidad']}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.map),
                          onPressed: () {
                            Navigator.pop(context); // Cierra el modal
                            // Aquí podrías añadir lógica para centrar el mapa en este albergue
                          },
                        ),
                        onTap: () {
                          // Muestra el mismo diálogo que al tocar el marcador
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildAlbergueDialog(albergue);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Método auxiliar para construir el diálogo (reutilizable)
  Widget _buildAlbergueDialog(dynamic albergue) {
    return AlertDialog(
      title: Text(albergue['edificio']),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ciudad: ${albergue['ciudad']}'),
          Text('Capacidad: ${albergue['capacidad']}'),
          Text('Teléfono: ${albergue['telefono']}'),
          if (albergue['codigo'] != null) Text('Código: ${albergue['codigo']}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAlbergues();
  }

  Future<void> _fetchAlbergues() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      setState(() {
        albergues = json.decode(response.body)['datos'];
      });
    } else {
      throw Exception('Failed to load albergues');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: Text("Maps"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 30),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 38
        ),
        actions: [
          IconButton(onPressed: _mostrarListaAlbergues, icon: Icon(Icons.list_outlined))
        ],
      ),
        body: FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(18.47186, -69.89232),
        initialZoom: 13,
        interactionOptions:
            InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
      ),
      children: [
        openStreetMapTileLater,
        MarkerLayer(markers: [
          for (var albergue in albergues)
            Marker(
                point: LatLng(double.parse(albergue['lng']),
                    double.parse(albergue['lat'])),
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.center,
                child: GestureDetector(
                    child: const Icon(Icons.location_on),
                    onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(albergue['edificio']),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Ciudad: ${albergue['ciudad']}'),
                                  Text('Capacidad: ${albergue['capacidad']}'),
                                  Text('Teléfono: ${albergue['telefono']}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Cerrar el AlertDialog
                                  },
                                  child: const Text(
                                    'Cerrar',
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 0, 0, 1)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ))),
        ])
      ],
    ));
  }
}

TileLayer get openStreetMapTileLater => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );

