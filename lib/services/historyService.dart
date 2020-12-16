import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reciclame/services/materialService.dart';

class HistoryService{
  static final HistoryService instance = HistoryService._internal();

  HistoryService._internal();

  factory HistoryService() => instance;

  getHistory() async {

    if(FirebaseAuth.instance.currentUser != null){
      List<Map<String,dynamic>> historic = new List();

      var materialsRefs = await MaterialService.instance.getAllMaterialsReferences();
      var aux = await FirebaseFirestore.instance.collection('history').where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
      var total = aux.docs.length;
      for(var material in materialsRefs){
        var snapshot = await FirebaseFirestore.instance.collection('history')
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .where("material", isEqualTo: material)
            .get();

        var materialName = await MaterialService.instance.getByReference(material);
        historic.add({"name":materialName["name"], "quantity":snapshot.docs.length,"total":total});
      }
      return historic;
    }
  }


}