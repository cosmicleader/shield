// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class ProfileController extends GetxController {
  // User? user;
  String city = 'London';

  @override
  void onInit() {
    super.onInit();
    // Get the user from Firebase Auth
    // user = FirebaseAuth.instance.currentUser;
  }

  void showAlert() {
    // Show an alert dialog
    Get.defaultDialog(
      radius: 8,
      title: 'Alert',
      middleText: 'This is an alert dialog',
      textConfirm: 'OK',
      onConfirm: () {
        Get.back();
      },
    );
  }
}
