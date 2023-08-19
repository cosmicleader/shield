import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final Rx<File?> profilePicture = Rx<File?>(null);

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profilePicture.value = File(pickedImage.path);
    }
  }

  Future<void> signUp() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text;
      final String displayName = displayNameController.text;
      final String phoneNumber = phoneNumberController.text;
      final String dateOfBirth = dateOfBirthController.text;
      final String gender = genderController.text;
      final String location = locationController.text;

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user?.updateProfile(
          displayName: displayName,
          photoURL: '',
        );

        final String? uid = userCredential.user?.uid;
        final CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');

        await usersCollection.doc(uid).set({
          'displayName': displayName,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'location': location,
        });

        // Upload profile picture if available
        if (profilePicture.value != null) {
          final String pictureUrl = await uploadProfilePicture(uid!);
          await userCredential.user?.updateProfile(photoURL: pictureUrl);
        }

        // Navigate to the next screen or perform necessary actions
        // For example: Get.offAllNamed('/home');
      } else {
        print('Signup failed');
      }
    } catch (e) {
      print('Signup error: $e');
    }
  }

  Future<String> uploadProfilePicture(String uid) async {
    // Implement your profile picture upload logic here
    // For example, using Firebase Storage
    // Return the picture URL after uploading
    return '';
  }
}
