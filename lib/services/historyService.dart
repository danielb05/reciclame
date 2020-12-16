import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reciclame/services/materialService.dart';

class HistoryService{
  static final HistoryService instance = HistoryService._internal();

  HistoryService._internal();

  factory HistoryService() => instance;

  getHistory() async {

    if(FirebaseAuth.instance.currentUser != null){
      var historic = {};

      var materialsRefs = await MaterialService.instance.getAllMaterialsReferences();
      
      for(var material in materialsRefs){
        var snapshot = await FirebaseFirestore.instance.collection('history')
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .where("material", isEqualTo: material)
            .get();
        var materialName = await MaterialService.instance.getByReference(material);
        historic[materialName["name"]] = snapshot.docs.length;
      }
      return historic;
    }
  }
}