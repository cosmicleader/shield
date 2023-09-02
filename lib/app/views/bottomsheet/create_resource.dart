import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';

import '../../controllers/resources_controller.dart';
import '../../models/resources_model.dart';
import '../themes/colours.dart';

class CreateResourceBottomSheet extends StatefulWidget {
  @override
  _CreateResourceBottomSheetState createState() =>
      _CreateResourceBottomSheetState();
}

class _CreateResourceBottomSheetState extends State<CreateResourceBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final authController = Get.put(AuthController());
  final resourceController = Get.put(ResourcesController());
  bool isAvailable = true;

  void createResource() async {
    try {
      // Get the current user, you should implement Firebase Authentication for this.
      // final User? user = FirebaseAuth.instance.currentUser;

      if (authController.user.value != null) {
        final resource = Resource(
          id: '', // Firestore will auto-generate an ID
          title: titleController.text,
          type: typeController.text,
          location: locationController.text,
          isAvailable: isAvailable,
          requests: [], // Initialize the requests array as empty
        );

        // Add the new resource to Firestore
        final DocumentReference resourceRef =
            await FirebaseFirestore.instance.collection('resources').add({
          'title': resource.title,
          'type': resource.type,
          'location': resource.location,
          'isAvailable': resource.isAvailable,
          'requests': resource.requests,
          'ownerId': authController
              .user.value!.uid, // Store the owner's ID for future reference
        });

        // Update the resource's ID with the auto-generated Firestore ID
        resource.id = resourceRef.id;

        // Add the new resource to the list
        resourceController.resources.add(resource);

        // Close the bottom sheet
        // Navigator.of(context).pop();
        Get.back(closeOverlays: true);
      }
    } catch (error) {
      debugPrint('Error creating resource: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create Resource',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 45,
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGray.withOpacity(0.25),
                hintText: 'Enter a meaningful title...',
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: kOrange),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 45,
            child: TextFormField(
              controller: typeController,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGray.withOpacity(0.25),
                hintText: 'Enter the type...',
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: kOrange),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 45,
            child: TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGray.withOpacity(0.25),
                hintText: 'Enter the location...',
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: kOrange),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Text('Availability:'),
              Checkbox(
                overlayColor:
                    MaterialStateColor.resolveWith((states) => kBlack),
                fillColor: MaterialStateColor.resolveWith((states) => kBlack),
                // checkColor: kBlack,
                value: isAvailable,
                onChanged: (value) {
                  setState(() {
                    isAvailable = value ?? false;
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(kBlack)),
            onPressed: createResource,
            child: const Text('Create Resource'),
          ),
        ],
      ),
    );
  }
}
