import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // Your Firestore stream
  final Stream<QuerySnapshot> _videoStream =
      FirebaseFirestore.instance.collection('videos').snapshots();
  Stream<QuerySnapshot> get videoStream => _videoStream;
  // Private constructor to prevent instantiation from outside
  DataProvider._();
  static final DataProvider _instance = DataProvider._();
  factory DataProvider() => _instance;

}
