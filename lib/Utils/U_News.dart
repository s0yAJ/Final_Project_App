import 'package:final_proyect/Models/NewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<NewModels>? Result_of_news = [];

class news_api{

  Future<void> GetAllNews() async{
    try{
      final url = Uri.parse("https://adamix.net/defensa_civil/def/noticias.php");

      final response = await http.get(url);

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        Result_of_news = data.map((dynamic items) => NewModels.fromJson(items)).toList();
      }
    }catch(ex){
      print(ex.toString());
    }
  }
}