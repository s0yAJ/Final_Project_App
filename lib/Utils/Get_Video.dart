import 'dart:async';
import 'dart:convert';
import 'package:final_proyect/Models/VideoModels.dart';
import 'package:http/http.dart' as http;

List<VideoModel> videos = [];

class GetVideo {

  Future<VideoModel> GetAllVideo() async {
    try {
      final url =
          Uri.parse("https://adamix.net/defensa_civil/def/videos.php");
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
}