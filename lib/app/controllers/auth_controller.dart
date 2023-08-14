import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    // Perform the sign-in
    isLoading.value = false;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // Similar to the previous example
  }

  Future<void> signInAnonymously() async {
    // Similar to the previous example
  }
}
