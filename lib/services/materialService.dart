import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialService {
  static final MaterialService instance = MaterialService._internal();

  MaterialService._internal();

  factory MaterialService() => instance;

  get(documentId) async {
    var snapshot = await FirebaseFirestore.instance.collection('materials').doc(documentId).get();
    print(snapshot);
  }

}
