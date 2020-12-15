import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/main.dart';
import 'package:reciclame/services/materialService.dart';
import 'package:reciclame/services/productService.dart';
import 'package:reciclame/widgets/ItemWidget.dart';
import 'package:reciclame/widgets/MaterialWidget.dart';

class FindView extends StatefulWidget {
  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  TextEditingController _name;
  bool found_object;
  List<dynamic> entries;
  List<dynamic> materialEntries;
  bool search;

  @override
  void initState() {
    super.initState();
    search = false;
    _name = TextEditingController();
    found_object = false;
    entries = [];
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  cleanSearchInput() {
    setState(() {
      _name.clear();
      found_object = false;
      entries = [];
    });
    search = false;
  }

  Future<List<dynamic>> _loadMaterials() async{
    materialEntries = [];
    materialEntries = await MaterialService.instance.getAllMaterials();
    return materialEntries;
  }

  @override
  Widget build(BuildContext context) {
    String lang = MyApp.getLang(context).split('_')[0];
    return Container(
      child: FutureBuilder(
        future: _loadMaterials(),
        builder: (context, snapshot){
          if(materialEntries != []) {
            return Container(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: Autocomplete Input (Optional)
                      // TODO: Find element depending language
                      TextField(
                        controller: _name,
                        onSubmitted: (String value) async {
                          if (value != "") {
                            var products = await ProductService.instance.getByName(value, lang: lang);
                            products.forEach((item) {
                              setState(() {
                                entries = products;
                                found_object = true;
                              });
                            });
                            search = true;
                          }
                        },
                        onChanged: (String value) async {
                          if (value.toLowerCase() == "") {
                            cleanSearchInput();
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter name",
                            labelText: getTranslated(context, 'name'),
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cleanSearchInput();
                              },
                              icon: Icon(Icons.clear),
                            )),
                      ),
                      SizedBox(height: 25.0),
                      if(search)
                        Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemCount: entries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(entries[index]);
                                    Navigator.pushNamed(context, '/item',
                                        arguments: entries[index]);
                                  },
                                  child: ItemWidget(entries: entries[index]),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                            )),
                      if(!search)
                        Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemCount: materialEntries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(materialEntries[index]);
                                    Navigator.pushNamed(context, '/item',
                                        arguments: materialEntries[index]);
                                  },
                                  child: ItemWidget(entries: materialEntries[index]),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                            )
                        )
                    ],
                  ),
                )
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
