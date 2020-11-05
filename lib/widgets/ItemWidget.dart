import 'package:flutter/material.dart';
class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key key,
    @required this.entries,
  }) : super(key: key);

  final String entries;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            backgroundImage:AssetImage('assets/'+entries+'.jpg'),
                            radius: 50.0,
                          ),
                        ),
                      ],
                    ),
                    Text('Entry $entries'),
                  ]),
            )
        )
    );
  }
}