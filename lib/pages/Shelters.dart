import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Shelters extends StatefulWidget {
  const Shelters({super.key});

  @override
  State<Shelters> createState() => _SheltersState();
}

class _SheltersState extends State<Shelters> {
  List<dynamic> shelters = [];
  List<dynamic> filteredShelters = [];
  bool isLoading = true;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    fetchShelters();
  }

  Future<void> fetchShelters() async {
    final response = await http
        .get(Uri.parse("https://adamix.net/defensa_civil/def/albergues.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        shelters = data['datos'];
        filteredShelters = shelters;
        isLoading = false;
      });
    } else {
      throw Exception('Error al cargar albergues');
    }
  }

  void filterShelters(String query) {
    final results = shelters.where((shelter) {
      final name = (shelter['edificio'] ?? '').toString().toLowerCase();
      final province = (shelter['ciudad'] ?? '').toString().toLowerCase();
      return name.contains(query.toLowerCase()) ||
          province.contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchText = query;
      filteredShelters = results;
    });
  }

  String getText(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'No disponible';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
         Colors.amber[700], // Fondo naranja claro

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      "Shelters:",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: filterShelters,
                    decoration: InputDecoration(
                      hintText: "Buscar albergue o provincia...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredShelters.length,
                    itemBuilder: (context, index) {
                      final shelter = filteredShelters[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        child: ListTile(
                          leading: const Icon(Icons.house_outlined,
                              color: Colors.teal),
                          title: Text(getText(shelter['edificio'])),
                          subtitle:
                              Text("Ciudad: ${getText(shelter['ciudad'])}"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ShelterDetails(shelter: shelter),
                              ),
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
  }
}

class ShelterDetails extends StatelessWidget {
  final Map<String, dynamic> shelter;

  const ShelterDetails({super.key, required this.shelter});

  String getText(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'No disponible';
    }
    return value.toString();
  }

  Widget infoText(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        "$label: ${getText(value)}",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 197, 113),
      appBar: AppBar(
        title: const Text("Detalle del Albergue"),
        backgroundColor: Colors.amber[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            infoText("Ciudad", shelter['ciudad']),
            infoText("Código", shelter['codigo']),
            infoText("Edificio", shelter['edificio']),
            infoText("Coordinador", shelter['coordinador']),
            infoText("Teléfono", shelter['telefono']),
            infoText("Latitud", shelter['lat']),
            infoText("Longitud", shelter['lng']),
          ],
        ),
      ),
    );
  }
}
