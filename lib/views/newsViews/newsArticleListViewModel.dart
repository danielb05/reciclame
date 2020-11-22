import 'package:flutter/cupertino.dart';
import 'package:reciclame/models/news_articles.dart';
import 'package:reciclame/services/webservice.dart';

import 'newsArticleViewModel.dart';

class NewsArticleListViewModel extends ChangeNotifier {
  List<NewsArticleViewModel> articles = List<NewsArticleViewModel>();

  void populateTopHeadlines(context) async {
    List<NewsArticle> newsArticles =
        await WebService().fetchTopHeadlines(context);
    this.articles = newsArticles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();
    notifyListeners();
  }
}
