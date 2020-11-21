import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reciclame/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContainerService {
  static final ContainerService instance = ContainerService._internal();

  ContainerService._internal();

  factory ContainerService() => instance;


  getAll() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('container')
        .get();

    snapshot.docs.forEach((doc) {

    });
  }

  getById() async {

  }

  getByName() async {

  }

}
