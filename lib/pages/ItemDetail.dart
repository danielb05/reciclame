import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final Map arguments;
  ItemDetail(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(arguments['item']),
    );
  }
}


