import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reciclame/views/newsViews/newsArticleListViewModel.dart';
import 'description.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}
class Post {
  final String title;
  final String description;
  Post(this.title, this.description);
}
Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  return List.generate(search.length, (int index) {
    return Post(
      "Title : $search $index",
      "Description :$search $index",
    );
  });
}
class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .populateTopHeadlines(context);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewsArticleListViewModel>(context);
    /*return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Post>(
            onSearch: search,
            onItemFound: (Post post, int index) {
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
              );
            },
          ),
        ),
      ),
    );*/
    return
      Container(
          child: ListView.builder(
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
                title: Text(articleStuff.title),
                onTap: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new DescriptionPage(articleStuff.url),
                      ));
                },
              );
            },
          ));
  }
}
