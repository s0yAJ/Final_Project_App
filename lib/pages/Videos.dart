import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_proyect/Models/VideoModels.dart';
import 'package:final_proyect/Utils/Get_Video.dart';
import 'package:final_proyect/Utils/Play.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late Future<VideoModel> videosCargados;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarVideos();
  }

  Future<void> _cargarVideos() async {
    final resultado = await GetAllVideo();
    if (mounted) {
      setState(() {
        videos = videos;
      });
    }
  }

  Future<VideoModel> GetAllVideo() async {
    try {
      final url = Uri.parse("https://adamix.net/defensa_civil/def/videos.php");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        videos = (data['datos'] as List)
            .map((dynamic item) => VideoModel.fromJson(item))
            .toList();

        return VideoModel.fromJson(data);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final videoId =
              YoutubePlayer.convertUrlToId(videos[index].link.toString());
          final videoTitle = videos[index].titulo;

          //Image.network(YoutubePlayer.getThumbnail(videoId: videoId!));
          return Card(
            margin: const EdgeInsets.only(top: 12),
            // color: Colors.black,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Play(videoId: videoId!)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                    ),
                    child: Image.network(
                      YoutubePlayer.getThumbnail(videoId: videoId!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      videoTitle.toString(),
                      style: const TextStyle(
                        // color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
