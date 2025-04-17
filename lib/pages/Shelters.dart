import 'package:final_proyect/Utils/defensa_appbar.dart';
import 'package:final_proyect/Utils/mapaview.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() =>
      _MapScreenState(); // Cambiado a _MapScreenState
}

class _MapScreenState extends State<MapScreen> {
  // Ahora es State<MapScreen>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefensaAppBar(context: context),
      body: MapaAlbergues(), // MapaAlbergues es un widget independiente
    );
  }
}
