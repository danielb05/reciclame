import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialService {
  static final MaterialService instance = MaterialService._internal();

  MaterialService._internal();

  factory MaterialService() => instance;

  getByReference(documentRef) async {
    var snapshot = await documentRef.get();
    return snapshot.data();
  }

  getByName(name, {lang = "en"}) async {
    var queryVal = lang == "es" ? "name_ES" : "name";
    var snapshot = await FirebaseFirestore.instance
        .collection('material')
        .where(queryVal, isEqualTo: name)
        .get();
    return (snapshot.docs[0].data());
  }


  getReferenceByName(name) async{
    var snapshot = await FirebaseFirestore.instance
        .collection('material')
        .where("name", isEqualTo: name)
        .get();
    return snapshot.docs[0].reference;
  }

  getAllMaterials() async {
    var snapshot = await FirebaseFirestore.instance.collection('material').get();

    List res = new List();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }
}
