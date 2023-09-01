import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shield/app/controllers/auth_controller.dart';

class RequestController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final authController = Get.put(AuthController());

  final firestore = FirebaseFirestore.instance;

  void uploadData() async {
    try {
      await firestore.collection('requests').add({
        'title': titleController.text,
        'description': descriptionController.text,
        'postedTime': DateTime.now(),
        'requestType': 'required',
        'uid': authController.user.value!.uid // Set the request type as needed
      });
    } catch (e) {
      log('Error uploading data: $e');
    }
  }

  @override
  void onClose() {
    // Clean up controllers when the controller is closed
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
