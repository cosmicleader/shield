import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';

import '../models/resources_model.dart';

class ResourcesController extends GetxController {
  var authController = Get.put(AuthController());
  var resources = <Resource>[].obs;
  var sortByValue = 'Availability'.obs;
  var filterByValue = 'All'.obs;

  Future<void> fetchResources() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('resources').get();
      resources.value = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final List<String> requests = List<String>.from(data['requests']);
        return Resource(
          id: doc.id,
          title: data['title'],
          type: data['type'],
          location: data['location'],
          isAvailable: data['isAvailable'],
          requests: requests,
        );
      }).toList();
    } catch (error) {
      debugPrint('Error fetching resources: $error');
    }
  }

  void sortResources() {
    if (sortByValue.value == 'Availability') {
      resources.sort((a, b) => a.isAvailable ? -1 : 1);
    }
  }

  void filterResources(String type) {
    filterByValue.value = type;
  }

  Future<void> requestResource(Resource resource) async {
    try {
      // final user = FirebaseAuth.instance.currentUser;
      if (authController.user.value != null) {
        // You can customize this logic as needed to track resource requests
        // For simplicity, we assume each resource has a "requests" field, which is an array of user IDs who have requested the resource.
        final updatedRequests = [
          ...resource.requests,
          authController.user.value!.uid
        ];
        await FirebaseFirestore.instance
            .collection('resources')
            .doc(resource.id)
            .update({'requests': updatedRequests});
        // Refresh the resources list
        fetchResources();
      }
    } catch (error) {
      debugPrint('Error requesting resource: $error');
    }
  }
}
