import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/models/resources_model.dart';
import 'package:shield/app/models/volunteer_request.dart';

class FirebaseService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> addResource(Map<String, dynamic> data) {
    return _firestore.collection('resources').add(data);
  }

  Future<void> updateResource(String resourceId, Resource data) {
    return _firestore.collection('resources').doc(resourceId).update({
      'title': data.title,
      'type': data.type,
      'location': data.location,
      'isAvailable': data.isAvailable,
    });
  }

//Read data from collection called "requests"
  Future<void> getRequest() async {
    try {
      var data = await _firestore.collection('requests').get();
      for (var doc in data.docs) {
        log(doc.data().toString());
      }
    } catch (e) {
      debugPrint('Error getting request: $e');
    }
  }

  Future<void> deleteResource(String resourceId) {
    return _firestore.collection('resources').doc(resourceId).delete();
  }

  Future<DocumentReference> addVolunteer(Map<String, dynamic> data) {
    return _firestore.collection('requests').add(data);
  }

  Future<void> updateVolunteer(String volunteerId, VolunteerRequest data) {
    return _firestore.collection('requests').doc(volunteerId).update({
      'title': data.title,
      'description': data.description,
      'postedTime': DateTime.now(),
      'requestType': data.requestType,
    });
  }

  Future<void> deleteVolunteer(String volunteerId) {
    return _firestore.collection('requests').doc(volunteerId).delete();
  }

  Stream<QuerySnapshot> getRequestsStream() {
    return _firestore.collection('requests').snapshots();
  }

  // Fetch user-specific resources based on the user's ID
  Future<QuerySnapshot> getMyResources(String userId) async {
    return await _firestore
        .collection('resources')
        .where('ownerId', isEqualTo: userId)
        .get();
  }

  // Fetch user-specific volunteer requests based on the user's ID
  Future<QuerySnapshot> getMyVolunteerRequests(String userId) async {
    return await _firestore
        .collection('requests')
        .where('uid', isEqualTo: userId)
        .get();
  }

  Future getGuidesList() async {
    return await _firestore.collection('guides').get();
    // return querySnapshot.docs
    //     .map((doc) => doc.data() as Map<String, dynamic>)
    //     .toList();
  }

  Future<void> requestResource({
    required String uid,
    required String phoneNumber,
    required String email,
    required String additionalDetails,
  }) async {
    // Add the data to Firestore
    await _firestore.collection('resourceRequests').doc(uid).set({
      'uid': uid,
      'phoneNumber': phoneNumber,
      'email': email,
      'additionalDetails': additionalDetails,
    });
  }

  Future<String?> getPhoneNumber(String uid) async {
    try {
      // Reference the Firestore collection and document with the given UID
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users') // Use the 'users' collection
          .doc(uid) // UID of the document you want to retrieve
          .get();

      // Check if the document exists
      if (snapshot.exists) {
        // Access the 'phoneNumber' field from the document data
        String? phoneNumber = snapshot.data()?['phoneNumber'];

        // Return the phone number
        return phoneNumber;
      } else {
        // Document with the provided UID does not exist
        return null;
      }
    } catch (e) {
      // Handle any errors, e.g., by returning a default value or logging the error
      print('Error retrieving phone number: $e');
      return null;
    }
  }
}
