import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reciclame/views/newsViews/newsArticleListViewModel.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .populateTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewsArticleListViewModel>(context);
    return Container(child: ListView.builder(
          shrinkWrap: true,
          itemCount: vm.articles.length,
          itemBuilder: (context, index) {
            final articleStuff = vm.articles[index];
            return ListTile(
              leading: Container(
                  width: 100,
                  height: 100,
                  child: articleStuff.imageUrl == null
                      ? Image.asset(
                          "assets/news.png",
                          width: 100,
                          height: 100,
                        )
                      : Image.network(
                          articleStuff.imageUrl,
                          width: 100,
                          height: 100,
                        )),
              title: Text(vm.articles[index].title),
            );
          },
        ));
  }
}
