import 'package:flutter/material.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/localization/language_constants.dart';

class ItemDetail extends StatefulWidget {
  final Map arguments;
  ItemDetail(this.arguments);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  String material;
  String bins;
  Color bin_color;

  @override
  void initState() {
    super.initState();
    String _material = "";
    String _bins = "";
    Color _bin_color;

    switch (widget.arguments['item']){
      case 'Coke Can':
        _bins='Yellow Bin - Light packaging';
        _material='Aluminium';
        _bin_color=Colors.yellow;
        break;
      case 'Coke Glass Bottle':
        _bins='Green Bin';
        _material='Glass';
        _bin_color=Colors.green;
        break;
      case 'Coke PET Bottle':
        _bins='Yellow Bin - Light packaging';
        _material='Plastic';
        _bin_color=Colors.yellow;
        break;
    }

    setState(() {
      material=_material;
      bins=_bins;
      bin_color=_bin_color;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments['item'].toUpperCase()),
        centerTitle: true),
      body: Center(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/'+widget.arguments['item']+'.jpg'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.all(20),
                      child: Chip(
                        label: Text(material),
                        backgroundColor: bin_color,
                      ),
                    ),
            SizedBox(height: 10.0),
            Container(
              child: Chip(
                label: Text(bins),
                backgroundColor: bin_color,
              ),
            ),
            SizedBox(height: 100),
            RaisedButton.icon(
                color: kPrimaryColor,
                onPressed: ()=>Navigator.pushNamed(context, '/home'),
                label: Text(getTranslated(context, 'title').toUpperCase()),
                icon: Icon(Icons.restore_from_trash),
            )
          ])),
    );
  }
}


