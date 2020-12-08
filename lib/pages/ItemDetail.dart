import 'package:flutter/material.dart';

import '../main.dart';

class ItemDetail extends StatefulWidget {
  final Map arguments;

  ItemDetail(this.arguments);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.arguments);
    String lang = MyApp.getLang(context).split('_')[0];
    // TODO: Match product with materials
    // TODO: Match materials with bins
    return Scaffold(
        appBar: AppBar(
            title: Text(lang == "en"
                ? widget.arguments['name']
                : widget.arguments['name_ES']),
            centerTitle: true),
        body: Center(
            child: Column(children: <Widget>[
              Container(
            margin: EdgeInsets.all(20),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.arguments['pictures'][0]), fit: BoxFit.fill),
            ),
          ),
          SizedBox(height: 10.0),
          /*Container(
          margin: EdgeInsets.all(20),
          child: Chip(
            label: Text(),
            backgroundColor: bin_color,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: Chip(
            label: Text(getTranslated(context, bins)),
            backgroundColor: ,
          ),
        ),
        SizedBox(height: 100),
        RaisedButton.icon(
          color: kPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/home');
          },
          label: Text(getTranslated(context, 'title').toUpperCase()),
          icon: Icon(Icons.restore_from_trash),
        )*/
        ])));
  }
}
