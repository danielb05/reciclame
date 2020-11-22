import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final UserService instance = UserService._internal();

  UserService._internal();

  factory UserService() => instance;

  Future<dynamic> getCurrentUserData(String uid) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('userData')
        .where('uid', isEqualTo: uid)
        .get();
    return (snapshot.docs[0].data());
  }
}
