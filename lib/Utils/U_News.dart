import 'package:final_proyect/Models/NewsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<NewModels>? Result_of_news = [];

class news_api {
  Future<NewModels> GetAllNews() async {
    try {
      final url =
          Uri.parse("https://adamix.net/defensa_civil/def/noticias.php");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Result_of_news = (data['datos'] as List)
            .map((dynamic item) => NewModels.fromJson(item))
            .toList();

        return NewModels.fromJson(data);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }
}
