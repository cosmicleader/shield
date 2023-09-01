import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';

class AcceptVolunteerRequestController extends GetxController {
  Future<void> confirmAction(String title) async {
    final authController = Get.put(AuthController());
    try {
      final uid = authController.getUID;
      final name = authController.getUserName;
      final number = authController.getUserPhoneNumber;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('titles')
          .doc(title)
          .collection('confirmed_entries')
          .where('UID', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Get.snackbar('Error', 'You have already confirmed this request.');
        return;
      }
      final data = {
        'UID': uid,
        'Name': name,
        'Number': number,
      };

      await FirebaseFirestore.instance
          .collection('titles')
          .doc(title)
          .collection('confirmed_entries')
          .add(data);

      Get.snackbar('Hi ${authController.usernameOrEmail}',
          'Confirmation uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
