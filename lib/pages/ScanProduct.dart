import 'package:flutter/material.dart';

class ScanProduct extends StatefulWidget {
  @override
  _ScanProductState createState() => _ScanProductState();
}

class _ScanProductState extends State<ScanProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(child: Image.asset('assets/ScanImage.jpeg'))));
  }
}
