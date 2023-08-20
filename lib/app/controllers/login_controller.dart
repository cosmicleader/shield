import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var authStatus = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Perform login or other actions here
      print('Form validated and submitted');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
      // Navigate to the next screen
      var _controller = Get.put(AuthController());
      _controller.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
      Get.back();
      _controller.update();
      authStatus = true;
      // Get.to(() => HomeScreen());
    }
  }
}
