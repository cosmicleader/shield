import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shield/app/views/themes/colours.dart';
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
  Future<bool> reauthenticateUser(String password) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);
        return true;
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        content: Text(
          "Reauthentication failed. ${e.toString()}",
          style: GoogleFonts.inter(color: kBlack),
        ),
        confirm: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => kBlack)),
          onPressed: () {
            Get.back();
          },
          child: const Text("OK"),
        ),
      );
    }
    return false;
  }

//Dialogue box to enter password and get back on success

  Future<void> updateEmail(String newEmail) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        update();
        Get.back(); // Close the dialog
        Get.defaultDialog(
          title: "Success",
          content: Text(
            "Email updated successfully!",
            style: GoogleFonts.inter(color: kBlack),
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kBlack)),
            onPressed: () {
              Get.back();
            },
            child: const Text("OK"),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      Get.defaultDialog(
        title: "Error",
        content: Text(e.toString()),
        confirm: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => kBlack)),
          onPressed: () {
            Get.back();
          },
          child: Text(
            "OK",
            style: GoogleFonts.inter(color: kBlack),
          ),
        ),
      );
    }
  }

  Future<void> updateName(String newName) async {
    try {
      // User user = _auth.currentUser;
      if (user.value != null) {
        // UserProfileChangeRequest profileUpdates = UserProfileChangeRequest();
        // profileUpdates.displayName = newName;

        await user.value!.updateDisplayName(newName);
        update();
        Get.back(); // Close the dialog
        Get.defaultDialog(
          title: "Success",
          content: Text(
            "Name updated successfully!",
            style: GoogleFonts.inter(color: kBlack),
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kBlack)),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "OK",
              style: GoogleFonts.inter(color: kBlack),
            ),
          ),
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        content: Text(e.toString()),
        confirm: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => kBlack)),
          onPressed: () {
            Get.back();
          },
          child: Text(
            "OK",
            style: GoogleFonts.inter(color: kBlack),
          ),
        ),
      );
    }
  }
}
