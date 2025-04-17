import 'package:final_proyect/pages/Measures.dart';
import 'package:final_proyect/utils/mapaview.dart';
import 'package:flutter/material.dart';

class AlberguesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.map,
                    color: Color.fromRGBO(239, 121, 42, 1),
                    size: 26,
                  ),
                  title: const Text(
                    'Vista de mapa',
                    style: TextStyle(
                        color: Color.fromRGBO(15, 67, 116, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 26),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapaAlbergues()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.warning,
                    color: Color.fromRGBO(239, 121, 42, 1),
                    size: 26,
                  ),
                  title: const Text(
                    'Medidas preventivas',
                    style: TextStyle(
                        color: Color.fromRGBO(15, 67, 116, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Measures()),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.58,
                ),
                Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    child: Image.asset(
                      'assets/banner.png',
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
