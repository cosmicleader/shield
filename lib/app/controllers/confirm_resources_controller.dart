import 'package:get/get.dart';
import 'package:shield/app/services/firebase_service.dart';

import 'auth_controller.dart';

class ConfirmResourcesController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final authController = Get.put(AuthController());
  // Get the current user's UID and email using GetX
  // User? get user => _auth.currentUser;

  void sendRequest(String additionalDetails) async {
    // Get the data from the controller and the user object
    String uid = authController.getUID; // User's UID
    String email = authController.getUserEmail; // User's email
    final String? phoneNumber = await FirebaseService().getPhoneNumber(uid);

    try {
      // Add the data to Firestore using GetX service
      await FirebaseService().requestResource(
        uid: uid,
        phoneNumber: phoneNumber ??
            "No Contact Number", // Replace with the user's phone number
        email: email,
        additionalDetails: additionalDetails,
      );

      // Close the dialog
      Get.back();

      // Optionally, you can show a success message using Get.snackbar
      Get.snackbar('Success', 'Request sent successfully');
    } catch (error) {
      // Handle any errors, e.g., show an error message using Get.snackbar
      Get.snackbar('Error', 'Error sending request: $error');
    }
  }
}
