import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static final ProductService instance = ProductService._internal();

  ProductService._internal();

  factory ProductService() => instance;

  getAllProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('product').get();

    List res = new List();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }

  getByName(name) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('product')
        .orderBy('name')
        .where('name',isGreaterThanOrEqualTo: name)
        .where('name',isLessThanOrEqualTo: name+'\uf8ff')
        .get();

    List res = new List();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }
}
