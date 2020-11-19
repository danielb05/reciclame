import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class UserService {

  static final UserService instance = UserService._internal();
  UserService._internal();

  CollectionReference userData = FirebaseFirestore.instance.collection('userData');

  factory UserService () => instance;


  getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    return userData.where('uid',isEqualTo: user.uid);
  }




}