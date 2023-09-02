import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    // Initialize the user data when the controller is created
    // getUserByUID('your_uid_here');
    super.onInit();
  }

//set user to null
  void clear() {
    user.value = null;
  }

  // Function to get a user by UID
  Future<void> getUserByUID(String uid) async {
    final CollectionReference usersCollection = _firestore.collection('users');
    QuerySnapshot userSnapshot =
        await usersCollection.where('uid', isEqualTo: uid).get();

    if (userSnapshot.docs.isNotEmpty) {
      user.value = UserModel.fromSnapshot(userSnapshot.docs[0]);
    } else {
      user.value = null;
    }
  }
}
