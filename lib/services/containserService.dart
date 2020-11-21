import 'package:cloud_firestore/cloud_firestore.dart';

class ContainerService {
  static final ContainerService instance = ContainerService._internal();

  ContainerService._internal();

  factory ContainerService() => instance;


  getAll() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('container')
        .get();

    List res = new List();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }

  getByName(name) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('container')
        .where('name', isEqualTo: name)
        .get();

    return (snapshot.docs[0].data());
  }

}
