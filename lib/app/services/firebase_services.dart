import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestore = FirebaseFirestore.instance;

Future<void> addRequest(Map<String, dynamic> requestData) async {
  try {
    await firestore.collection('requests').add(requestData);
  } catch (e) {
    debugPrint('Error adding request: $e');
  }
}

Future<void> updateRequest(String id, Map<String, dynamic> requestData) async {
  try {
    await firestore.collection('requests').doc(id).update(requestData);
  } catch (e) {
    debugPrint('Error updating request: $e');
  }
}

Future<void> deleteRequest(String id) async {
  try {
    await firestore.collection('requests').doc(id).delete();
  } catch (e) {
    debugPrint('Error deleting request: $e');
  }
}

//Read data from collection called "requests"
Future<void> getRequest() async {
  try {
    var data = await firestore.collection('requests').get();
    for (var doc in data.docs) {
      log(doc.data().toString());
    }
  } catch (e) {
    debugPrint('Error getting request: $e');
  }
}
