import 'package:flutter/material.dart';

class AcercaPage extends StatelessWidget {
  final List<Map<String, String>> integrantes = [
    {"nombre": "Jeff Robinson Coplin Mancebo", "matricula": "20220810"},
    {"nombre": "Yacell Jiménez Peña", "matricula": "20220306"},
    {"nombre": "Francisco Rodríguez", "matricula": "20211408"},
    {"nombre": "Adrian J. Ortiz M.", "matricula": "20220681"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acerca de")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/icono.jpeg'),
              ),
              SizedBox(height: 16),
              Text(
                "Desarrollado por el Grupo The Flutter Squad",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Link de repositorio: https://github.com/s0yAJ/Final_Project_App",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Divider(),
              Text(
                "Integrantes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              ...integrantes.map((integrante) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      children: [
                        Icon(Icons.person_outline,
                            color: Colors.orange, size: 30),
                        SizedBox(height: 4),
                        Text(
                          integrante['nombre']!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Matrícula: ${integrante['matricula']}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
