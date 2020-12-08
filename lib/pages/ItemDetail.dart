import 'package:flutter/material.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/materialService.dart';

import '../main.dart';

class Item {
  Item({this.isExpanded = false, this.header = "Description", this.description});

  bool isExpanded;
  String header;
  String description;
}

class ItemDetail extends StatefulWidget {
  final Map arguments;

  ItemDetail(this.arguments);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  List<Item> listItems = new List<Item>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      listItems.add(new Item(description: widget.arguments["description"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.arguments['materials'][0]);
    //MaterialService.instance.get(widget.arguments['materials'][0])
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
                  image: NetworkImage(widget.arguments['pictures'][0]),
                  fit: BoxFit.fill),
            ),
          ),
          SizedBox(height: 10.0),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                listItems[index].isExpanded = !isExpanded;
              });
            },
            children: listItems.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.header),
                  );
                },
                body: ListTile(
                  title: Text(item.description),
                  subtitle: Text(''),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
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
          )
        ])));
  }
}
