import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';

class FindView extends StatefulWidget {
  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  TextEditingController _name;
  bool found_object;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    found_object = false;
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _name,
              onSubmitted: (String value) async {
                setState(() {
                  found_object = value.toLowerCase() == 'coke';
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
                    });
                    },
                  icon: Icon(Icons.clear),
                )
              ),
            ),
            SizedBox(height: 10.0),
            Container(child: found_object?Text('$found_object'):Text('$found_object'))
          ],
        ),
      )
    );
  }
}
