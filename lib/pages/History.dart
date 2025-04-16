import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/defensa.png',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Historia de la Defensa Civil",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "La Defensa Civil fue fundada con la misión de proteger a la población ante situaciones de emergencia y desastres naturales. A lo largo de los años, ha sido una institución clave en labores de rescate, prevención y educación ciudadana en todo el territorio nacional.",
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                "Su historia está marcada por el compromiso, la valentía y la entrega de miles de voluntarios que han salvado vidas y contribuido al bienestar colectivo.",
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
              Text(
                "Gracias por confiar en nosotros.",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
