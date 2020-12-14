import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/containserService.dart';
import 'package:reciclame/services/materialService.dart';
import 'package:reciclame/services/productService.dart';

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
  bool isMaterial;

  @override
  void initState() {
    print(widget.arguments);
    // TODO: implement initState
    super.initState();
    setState(() {
      listItems.add(new Item(description: widget.arguments["description"]));
    });
    ProductService.instance.isMaterial(widget.arguments["name"]).then((value){
      setState(() {
        isMaterial = value;
      });
    });
  }

  Future getContainers() async {
    List bins = new List();
    for (var materialDocRef in widget.arguments['materials']) {
      var value = await ContainerService.instance.findContainer(materialDocRef);
      bins.add(value);
    }
    return Future.value(bins);
  }

  Future getMaterials() async {
    List materialList = new List();

    for (var materialDocRef in widget.arguments['materials']) {
      var value = await MaterialService.instance.getByReference(materialDocRef);
      materialList.add(value);
    }
    return Future.value(materialList);
  }

  Future getProducts() async {
    var products = await ProductService.instance.getByMaterial(widget.arguments['name']);
    return Future.value(products);
  }

  @override
  Widget build(BuildContext context) {
    String lang = MyApp.getLang(context).split('_')[0];
    // TODO: Match product with materials
    // TODO: Match materials with bins
    return Scaffold(
        appBar: AppBar(
            title: Text(lang == "en"
                ? widget.arguments['name']
                : widget.arguments['name_ES']),
            centerTitle: true),
        body: !(isMaterial??false) ? Center(
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
          SizedBox(height: 40),
              FutureBuilder(
                future: getMaterials(), // function where you call your api
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Expanded(
                        child: new ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                  child: Chip(
                                      label:
                                      Text('${snapshot.data[index]["name"]}')));
                            }),
                      );
                    }
                  }
                },
              ),
          Divider(color: Colors.black,),
          FutureBuilder(
            future: getContainers(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              // AsyncSnapshot<Your object type>
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: Chip(
                                  label:
                                      Text('${snapshot.data[index]["name"]}'),
                                  backgroundColor:
                                      HexColor(snapshot.data[index]["color"])));
                        }),
                  );
                }
              }
            },
          ),
          RaisedButton.icon(
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
            label: Text(getTranslated(context, 'title').toUpperCase()),
            icon: Icon(Icons.restore_from_trash),
          ),
          SizedBox(height: 40)
        ])):Center(
          child: FutureBuilder(
          future: getProducts(), // function where you call your api
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Text(snapshot.data.toString())
                ;
              }
            }
          },
        ),


    ));
  }
}
