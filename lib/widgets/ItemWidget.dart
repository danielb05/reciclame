import 'package:flutter/material.dart';
import 'package:reciclame/main.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key key,
    @required this.entries,
  }) : super(key: key);

  final Map<dynamic, dynamic> entries;

  @override
  Widget build(BuildContext context) {
    String lang = MyApp.getLang(context).split('_')[0];
    return Card(
        color: Colors.green[100],
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Row(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/' + "anonymous" + '.jpg'),
                        radius: 50.0,
                      ),
                    ),
                  ],
                ),
                Text(lang == "en" ? entries['name'] : entries['name_ES'])
              ]),
            )));
  }
}
