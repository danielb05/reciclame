import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reciclame/services/materialService.dart';

class ContainerService {
  static final ContainerService instance = ContainerService._internal();

  ContainerService._internal();

  factory ContainerService() => instance;

  getAll() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('container').get();

    List res = new List();

    snapshot.docs.forEach((doc) {
      res.add(doc.data());
    });

    return res;
  }

  findContainer(material) async {
    for(var container in await getAll()){
       for(var _material in container["materials"]){
        if (material == _material) {
          //print(await MaterialService.instance.getByReference(material));
          return container;
        }
      }
    }
  }
}
