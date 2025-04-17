import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Image.asset(
                'assets/defensa.png',
                fit: BoxFit.contain,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      "Historia de la Defensa Civil",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "La Defensa Civil fue fundada con la misión de proteger a la población ante situaciones de emergencia y desastres naturales. A lo largo de los años, ha sido una institución clave en labores de rescate, prevención y educación ciudadana en todo el territorio nacional.\n",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "Salvaguardar la integridad física de las personas ante la eventualidad de un desastre provocado por agentes naturales o humanos, a través de acciones que reduzcan o eliminen la pérdida de vidas humanas, la destrucción de bienes materiales y el daño a la naturaleza.\n",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "La Dirección General de Defensa Civil trabaja, en lo que hace a la respuesta ante emergencias (incendios, derrames de sustancias tóxicas, inundaciones, etc.) en coordinación con los demás organismos intervinientes para salvaguardar la vida y los bienes de la población y mitigar los posibles riesgos asociados al evento.",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Su historia está marcada por el compromiso, la valentía y la entrega de miles de voluntarios que han salvado vidas y contribuido al bienestar colectivo.",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Gracias por confiar en nosotros.",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.orange[300],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
