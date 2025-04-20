import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontSize: 16,
      height: 1.5,
      color: Colors.black,
    );

    return Padding(
      padding: EdgeInsets.all(0),
      child: SingleChildScrollView(
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
                      const SizedBox(height: 16),
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
                              style: textStyle,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Antes del año 1966, cuando llegaba la temporada de huracanes, un grupo de radioaficionados se reunía en la Cruz Roja para estar atentos por si surgía algún tipo de emergencia, inmediatamente ponerse a disposición y ayudar en todo lo posible, inclusive, usando sus propios equipos de comunicación para así tener contacto con el exterior en caso de que las redes telefónicas resultaran afectadas.",
                              style: textStyle,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Al surgir el triunvirato fue designado el Dr. Rafael Cantizano Arias, como presidente de la Cruz Roja y al mismo tiempo nombraron al Ing. Carlos D' Franco como director de la Defensa Civil, quien con un grupo compuesto por seis personas, se instaló en la calle Francia esquina Galván, siendo esa la primera oficina de la Defensa Civil.",
                              style: textStyle,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Al surgir el Gobierno Provisional, presidido por el Dr. Héctor García Godoy, a los diecisiete días del mes de junio de 1966, fue promulgada la Ley 257, mediante la cual fue creada la Defensa Civil, institución dependiente de la Secretaría Administrativa de la Presidencia (ahora Ministerio de la Presidencia) y quien en la actualidad preside la Comisión Nacional de Emergencias.",
                              style: textStyle,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Más adelante, el local fue trasladado a la calle Dr. Delgado No. 164 y luego en la gestión del Contralmirante Radhamés Lora Salcedo se reubicó a la Plaza de la Salud, donde aún permanece.",
                              style: textStyle,
                              textAlign: TextAlign.justify,
                            )
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
      ),
    );
  }
}
