import 'package:flutter/material.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/localization/language_constants.dart';

class FindView extends StatefulWidget {
  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  TextEditingController _name;
  bool found_object;
  List<String> entries;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    found_object = false;
    entries = [];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _name,
              onSubmitted: (String value) async {
                setState(() {
                  if(value.toLowerCase() =='coke'){
                    setState(() {
                      found_object = true;
                      entries = <String>['Coke Can', 'Coke Glass Bottle', 'Coke PET Bottle'];
                    });
                  }
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter name",
                labelText: getTranslated(context, 'name'),
                prefixIcon: Icon(Icons.search),
                suffixIcon:IconButton(
                  onPressed: (){
                    _name.clear();
                    setState(() {
                      found_object=false;
                      entries = [];
                    });
                    },
                  icon: Icon(Icons.clear),
                )
              ),
            ),
            SizedBox(height: 25.0),
            Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    print(entries[index]);
                  },
                  child: Container(
                      height: 150,
                      color: Colors.green[100],
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child:Center(
                            child:
                            Row(
                                children:[
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: CircleAvatar(
                                          backgroundImage:AssetImage('assets/'+entries[index]+'.jpg'),
                                          radius: 50.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('Entry ${entries[index]}'),
                                ]),
                          )
                      )
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ))
          ],
        ),
      )
    );
  }
}
