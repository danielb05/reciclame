import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reciclame/main.dart';
import 'package:reciclame/models/news_articles.dart';

class WebService {
  Future<List<NewsArticle>> fetchTopHeadlines(context) async {
    var lang = MyApp.getLang(context).split('_')[0];
    String url =
        "https://newsapi.org/v2/everything?q=(recycling OR environment)&language="+lang+"&sortBy=relevancy&apiKey=d77168d5d2294b63a14f0baceeda26e6";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["articles"];
      return list.map((article) => NewsArticle.fromJSON(article)).toList();
    } else {
      throw Exception(
          "Failed to retrieve top news! Please check your connection!");
    }
  }
}
