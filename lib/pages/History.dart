import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
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
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          Text(
                            "La Defensa Civil fue fundada con la misión de proteger a la población ante situaciones de emergencia y desastres naturales. A lo largo de los años, ha sido una institución clave en labores de rescate, prevención y educación ciudadana en todo el territorio nacional.",
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
                          const SizedBox(height: 16),
                          Text(
                            "La protección civil o defensa civil actúa en todos los estadios de la gestión integral de riesgo: En la prevención, a largo plazo, a medio plazo y a corto plazo. Es la encargada de declarar la alerta, la emergencia. Coordina las acciones que están destinadas a mitigar las situaciones de emergencia.",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Proporcionar apoyo y cooperación oportuna a la población afectada por emergencias. Apoyar y cooperar en la recepción acopio y distribución, de la ayuda humanitaria que se reciba para fines de emergencia, así como la que se envíe al exterior en casos similares.",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Contribuir a la prevención y mitigación de desastres, brindando orientación, asesoría y apoyo a las instancias integrantes del Sistema Estatal de Protección Civil y fomentar en la población la cultura de protección civil mediante el autocuidado y la autoprotección, así como proporcionar el auxilio necesario a la población en caso de contingencia, procurando el regreso a la normalidad  lo más rápido posible.",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
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
            ],
          ),
        ),
      ),
    );
  }
}
