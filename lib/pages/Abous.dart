import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaPage extends StatelessWidget {
  final List<Map<String, String>> integrantes = [
    {"nombre": "Jeff Robinson Coplin Mancebo", "matricula": "2022-0810"},
    {"nombre": "Yacell Jiménez Peña", "matricula": "2022-0306"},
    {"nombre": "Francisco Rodríguez", "matricula": "2021-1408"},
    {"nombre": "Adrian J. Ortiz M.", "matricula": "2022-0681"},
    {"nombre": "Dienely Meily Frias.", "matricula": "2023-0185"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      appBar: AppBar(title: Text("Acerca de"),
      centerTitle: true,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 170,
                backgroundImage: AssetImage('assets/icono.jpeg'),
              ),
              SizedBox(height: 16),
              Text(
                "Desarrollado: Grupo The Flutter Squad",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () async {
                final url = Uri.parse("https://github.com/s0yAJ/Final_Project_App");
                if(await canLaunchUrl(url)){
                  await canLaunchUrl(url);
                }else{
                  throw 'No se pudo abrir el enlace';
                }
              }, child: Text("Respositorio")),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 350,
                        color: Colors.white,
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
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
