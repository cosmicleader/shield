import 'package:flutter/cupertino.dart';
// import firebase from 'firebase';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
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

      // Create the user using createUserWithEmailAndPassword
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        final String uid = user.uid;
        final CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');

        // Use batch writes for better efficiency and atomicity
        WriteBatch batch = FirebaseFirestore.instance.batch();
        DocumentReference userDocRef = usersCollection.doc(uid);

        batch.set(userDocRef, {
          'displayName': displayName,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'location': location,
        });

        // Upload profile picture if available
        if (profilePicture.value != null) {
          final String pictureUrl =
              await uploadProfilePicture(uid, profilePicture.value!);
          batch.update(userDocRef, {'photoURL': pictureUrl});
        }

        // Commit the batch write
        await batch.commit();
        await user.updateDisplayName(displayName);
        // await user.updatePhoneNumber(phoneNumber);
        // Navigate to the next screen
        Get.offAllNamed('/home');
      } else {
        debugPrint('Signup failed');
      }
    } catch (e) {
      debugPrint('Signup error: $e');
    }
  }

  // Future<void> signUp() async {
  //   try {
  //     final String email = emailController.text.trim();
  //     final String password = passwordController.text;
  //     final String displayName = displayNameController.text;
  //     final String phoneNumber = phoneNumberController.text;
  //     final String dateOfBirth = dateOfBirthController.text;
  //     final String gender = genderController.text;
  //     final String location = locationController.text;

  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     if (userCredential.user != null) {
  //       // await userCredential.user?.updateProfile(
  //       //   displayName: displayName,
  //       //   photoURL: '',
  //       // );
  //       await userCredential.user!.updatePhotoURL('');

  //       final String? uid = userCredential.user?.uid;
  //       final CollectionReference usersCollection =
  //           FirebaseFirestore.instance.collection('users');

  //       await usersCollection.doc(uid).set({
  //         'displayName': displayName,
  //         'phoneNumber': phoneNumber,
  //         'dateOfBirth': dateOfBirth,
  //         'gender': gender,
  //         'location': location,
  //       });

  //       // Upload profile picture if available
  //       if (profilePicture.value != null) {
  //         final String pictureUrl =
  //             await uploadProfilePicture(uid!, profilePicture.value!);
  //         await userCredential.user!.updatePhotoURL(pictureUrl);
  //         // await userCredential.user?.updateProfile(photoURL: pictureUrl);
  //       }

  //       // Navigate to the next screen or perform necessary actions
  //       // For example: Get.offAllNamed('/home');
  //     } else {
  //       debugPrint('Signup failed');
  //     }
  //   } catch (e) {
  //     debugPrint('Signup error: $e');
  //   }
  // }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      signUp();
    }
  }

  Future<String> uploadProfilePicture(String uid, File imageFile) async {
    // Implement your profile picture upload logic here
    // For example, using Firebase Storage
    try {
      // Create a reference to the Firebase Storage bucket.
      final storageRef = FirebaseStorage.instance.ref('profile_pictures');

      // Create a unique file name for the image.
      String fileName = imageFile.path.split('/').last;

      // Upload the image to Firebase Storage.
      UploadTask uploadTask = storageRef.child(fileName).putFile(imageFile);

      // Wait for the upload to complete.
      await uploadTask.whenComplete(() {});

      // Get the download URL of the image.
      String downloadURL = await storageRef.child(fileName).getDownloadURL();

      return downloadURL;
    } catch (e) {
      debugPrint('Upload error: $e');
    }
    // Return the picture URL after uploading

    return '';
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              dateOfBirthController.text =
                  "${newDateTime.year}-${newDateTime.month}-${newDateTime.day}";
            },
          ),
        );
      },
    );
    if (picked != null && picked != DateTime.now()) {
      dateOfBirthController.text =
          "${picked.year}-${picked.month}-${picked.day}";
    }
  }
}
