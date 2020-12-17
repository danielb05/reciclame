import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/containserService.dart';
import 'package:reciclame/services/materialService.dart';
import 'package:reciclame/services/productService.dart';
import 'package:reciclame/widgets/ItemWidget.dart';
import "dart:core";
import '../main.dart';

class Item {
  Item(
      {this.isExpanded = false, this.header = "Description", this.description});

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
    // TODO: implement initState
    super.initState();
    setState(() {
      listItems.add(new Item(description: widget.arguments["description"]));
    });
    ProductService.instance.isMaterial(widget.arguments["name"]).then((value) {
      setState(() {
        isMaterial = value;
      });
    });
  }

  showAlertDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String quantity;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        try{

        }catch(ex){
          print(ex);
        }
        _formKey.currentState.save();

        //Navigator.pop(context);
        //Navigator.pushReplacementNamed(context, '/home');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: "1",
          keyboardType: TextInputType.number,
          onSaved: (newValue) => quantity = (newValue),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            labelText: "Quantity",
            hintText: "Enter valid Quantity",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.add_circle_rounded, color: kPrimaryColor),
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
    var products =
        await ProductService.instance.getByMaterial(widget.arguments['name']);
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
        body: !(isMaterial ?? false)
            ? Center(
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
                  future: getMaterials(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                        label: Text(
                                            '${snapshot.data[index]["name"]}')));
                              }),
                        );
                      }
                    }
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                FutureBuilder(
                  future: getContainers(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                        label: Text(
                                            '${snapshot.data[index]["name"]}'),
                                        backgroundColor: HexColor(
                                            snapshot.data[index]["color"])));
                              }),
                        );
                      }
                    }
                  },
                ),
                if(FirebaseAuth.instance.currentUser!=null)
                RaisedButton.icon(
                  color: kPrimaryColor,
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  label: Text(getTranslated(context, 'title').toUpperCase()),
                  icon: Icon(Icons.restore_from_trash),
                ),
                SizedBox(height: 40)
              ]))
            : Center(
                child: FutureBuilder(
                  future: getProducts(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return  ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/item',
                                    arguments: snapshot.data[index]);
                              },
                              child: ItemWidget(entries: snapshot.data[index]),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                      }
                    }
                  },
                ),
              ));
  }
}
