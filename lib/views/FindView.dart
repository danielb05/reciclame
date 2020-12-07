import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/productService.dart';
import 'package:reciclame/widgets/ItemWidget.dart';

class FindView extends StatefulWidget {
  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  TextEditingController _name;
  bool found_object;
  List<dynamic> entries;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    found_object = false;
    entries = [];
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(padding: EdgeInsets.all(15.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // TODO: Autocomplete Input (Optional)
            TextField(
            controller: _name,
            onSubmitted: (String value) async {

              var products = await ProductService.instance.getByName(value);
              print(products);

              // TODO: Find element depending language
              // TODO: Match product with materials
              // TODO: Match materials with bins
              /*setState(() {
                if (value.toLowerCase() == 'coke') {
                  setState(() {
                    found_object = true;
                    entries = <dynamic>[
                    ];
                  });
                }
              });*/
            },
            onChanged: (String value) async {
              if(value.toLowerCase() == ""){
                setState(() {
                  _name.clear();
                  found_object = false;
                  entries = [];
                });
              }
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter name",
                labelText: getTranslated(context, 'name'),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _name.clear();
                    setState(() {
                      found_object = false;
                      entries = [];
                    });
                  },
                  icon: Icon(Icons.clear),
                )),
          ),
            SizedBox(height: 25.0),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(entries[index]);
                      Navigator.pushNamed(context, '/item',
                          arguments: {"item": entries[index]});
                    },
                    child: ItemWidget(entries: entries[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ))
        ],
      ),
    ));
  }
}
