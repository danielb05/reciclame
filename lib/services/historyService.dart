import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryService{
  static final HistoryService instance = HistoryService._internal();

  HistoryService._internal();

  factory HistoryService() => instance;

  getHistory() async {

    await FirebaseFirestore.instance.collection('product').get();
  }
}