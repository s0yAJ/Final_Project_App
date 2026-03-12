import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_proyect/Models/VideoModels.dart';
import 'package:final_proyect/Utils/Play.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  List<VideoModel> videos = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _cargarVideos();
  }

  Future<void> _cargarVideos() async {
    try {
      final url = Uri.parse("https://adamix.net/defensa_civil/def/videos.php");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (mounted) {
          setState(() {
            videos = (data['datos'] as List)
                .map((dynamic item) => VideoModel.fromJson(item))
                .toList();
            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            errorMessage = 'Error al cargar videos (${response.statusCode})';
            isLoading = false;
          });
        }
      }
    } catch (ex) {
      if (mounted) {
        setState(() {
          errorMessage = 'Error de conexión. Verifica tu internet.';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 64, color: Colors.white70),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    errorMessage = null;
                  });
                  _cargarVideos();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.amber[700],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (videos.isEmpty) {
      return const Center(
        child: Text(
          'No hay videos disponibles',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final videoId =
              YoutubePlayer.convertUrlToId(videos[index].link.toString());
          final videoTitle = videos[index].titulo ?? 'Sin título';
          final videoDesc = videos[index].descripcion ?? '';

          if (videoId == null) return const SizedBox.shrink();

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Play(
                          videoId: videoId,
                          videoTitle: videoTitle,
                        )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          YoutubePlayer.getThumbnail(videoId: videoId),
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.broken_image,
                                  size: 48, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videoTitle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(15, 67, 116, 1),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (videoDesc.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            videoDesc,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
