import 'package:flutter/material.dart';
import 'package:final_proyect/Utils/U_News.dart';
import 'package:final_proyect/Models/NewsModel.dart';
import 'package:final_proyect/Utils/albergues_drawer.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future<NewModels> futureNoticias;

  @override
  void initState() {
    super.initState();
    futureNoticias = news_api().GetAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AlberguesDrawer(),
      backgroundColor: Colors.amber[700],
      // appBar: AppBar(title: const Text('Noticias')),
      body: FutureBuilder<NewModels>(
        future: futureNoticias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las noticias'));
          }

          if (!snapshot.hasData ||
              snapshot.data!.datos == null ||
              snapshot.data!.datos!.isEmpty) {
            return const Center(child: Text('No hay noticias disponibles'));
          }

          final datos = snapshot.data!.datos!;

          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: datos.length,
              itemBuilder: (context, index) {
                final noticia = datos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (noticia.foto != null && noticia.foto!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)
                          ),
                          child: Image.network(
                            noticia.foto!,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 100),
                          ),
                        )
                      else
                        const SizedBox(
                          height: 180,
                          child: Center(child: Icon(Icons.image_not_supported)),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: ListTile(
                          title: Text(
                            noticia.titulo ?? "Sin título",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            noticia.contenido ?? "Sin contenido",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
