import 'dart:convert';
import 'package:final_proyect/Utils/defensa_appbar.dart';
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
        appBar: DefensaAppBar(context: context),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Ciudad: ${albergue['ciudad']}'),
                                      Text(
                                          'Capacidad: ${albergue['capacidad']}'),
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
                                            color:
                                                Color.fromRGBO(255, 0, 0, 1)),
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
