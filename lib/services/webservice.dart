import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reciclame/models/news_articles.dart';

class WebService {
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d77168d5d2294b63a14f0baceeda26e6";
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
