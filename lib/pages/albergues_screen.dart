import 'dart:convert';
import 'package:final_proyect/Utils/albergue_row.dart';
import 'package:final_proyect/Utils/defensa_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AlberguesScreen extends StatefulWidget {
  const AlberguesScreen({super.key});

  @override
  State<AlberguesScreen> createState() => _AlberguesScreenState();
}

class _AlberguesScreenState extends State<AlberguesScreen> {
  List<dynamic> alberguesList = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> getAlbergues() async {
    setState(() {
      isLoading = true;
    });
    final String apiURL = 'https://adamix.net/defensa_civil/def/albergues.php';
    try {
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          alberguesList = jsonData["datos"];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Error al obtener los datos: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al obtener los albergues: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAlbergues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefensaAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Listado de albergues',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(15, 67, 116, 1),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            isLoading
                ? CircularProgressIndicator()
                : errorMessage.isNotEmpty
                    ? Text(errorMessage)
                    : Expanded(
                        child: ListView.builder(
                          itemCount: alberguesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final albergue = alberguesList[index];
                            return AlbergueRow(
                              title: albergue["edificio"],
                              city: albergue["ciudad"],
                              phoneNumber: albergue["telefono"],
                              capacity: albergue["capacidad"],
                              code: albergue["codigo"],
                              coordinator: albergue["coordinador"],
                              lat: albergue["lng"],
                              lon: albergue["lat"],
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
