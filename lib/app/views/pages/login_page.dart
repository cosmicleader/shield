import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LoginForum(),
                        _build10pxSpace(),
                        _buildGoogleSignIn(),
                      ],
                    ),
                  ),
                ),
                _buildSignupButton(),
              ],
            ),
            _buildBackButton(),
          ],
        ),
      ),
    );
  }

  InkWell _buildGoogleSignIn() {
    return InkWell(
      onTap: () {
        final authController = Get.put(AuthController());
        authController.signInWithGoogle();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xff1b1b1b),
            borderRadius: BorderRadius.circular(8)),
        child: const Center(
            child: Text(
          "Sign in with Google",
          style: TextStyle(
            color: Color(0xFFffffff),
            fontSize: 16,
          ),
        )),
      ),
    );
  }

  Container _buildBackButton() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      // width: 200,
      height: 45,
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFf1b1b1b),
            ),
          ),
          const Text(
            "Back",
            style: TextStyle(
              color: Color(0xFf1b1b1b),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildSignupButton() {
    return Positioned(
        // bottom: 100,
        bottom: 0,
        child: Center(
          child: TextButton(
            onPressed: () => Get.toNamed('/signup'),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Color(0xff1b1b1b)),
            ),
            child: const Text(r"I don't have an account"),
          ),
        ));
  }

  SizedBox _build10pxSpace() => const SizedBox(height: 10.0);
}
