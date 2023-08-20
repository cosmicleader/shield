import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((currentUser) {
      user.value = currentUser;
    });
  }

  bool get isAuthenticated => user.value != null;
  String? get usernameOrEmail => user.value?.displayName ?? user.value?.email;

  void signOut() async {
    await _auth.signOut();
  }

  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        isLoading.value = false;
      }
    } catch (error) {
      debugPrint('Google sign-in error: $error');
      isLoading.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Sign in successful, navigate to the next screen or perform necessary actions
    } on FirebaseAuthException catch (e) {
      String errorMessage = getErrorMessage(e);
      Get.closeAllSnackbars();

      // Show a snackbar with the error message
      Get.snackbar(
        'Sign-In Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email. Please check the email address.';
      case 'wrong-password':
        return 'Incorrect password. Please verify your password.';
      case 'invalid-email':
        return 'Invalid email address. Please enter a valid email.';
      case 'too-many-requests':
        return 'Too many sign-in attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      default:
        return 'An error occurred during sign-in. Please try again.';
    }
  }

  Future<void> signInAnonymously() async {
    // Similar to the previous example
  }
}
