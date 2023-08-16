import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginWithEmailAndPassword(),
                    _build10pxSpace(),
                    Container(
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
                          color: Color(0xFFffffff), // Use the color code here
                          fontSize: 16, // Set the desired font size
                          // You can also customize other text styles here
                        ),
                      )),
                    ),
                    // temp()
                  ],
                ),
              ),
            ),
            _buildSignupButton(),
            const SizedBox(
              width: 200,
              height: 45,
              child: Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFf1b1b1b), // Use the color code here
                  fontSize: 16, // Set the desired font size
                  // You can also customize other text styles here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildSignupButton() {
    return Positioned(
        // bottom: 100,
        bottom: 0,
        child: Center(
          child: TextButton(
            onPressed: () => Get.snackbar("I have no acount", "Message"),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Color(0xff1b1b1b)),
            ),
            child: const Text(r"I don't have an account"),
          ),
        ));
  }

  Row temp() {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: _authController.isLoading.value
              ? null
              : _authController.signInWithGoogle,
          icon: const Icon(Icons.login, color: Colors.white),
          label: _authController.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text('Sign in with Google'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff1b1b1b),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: _authController.isLoading.value
              ? null
              : _authController.signInAnonymously,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff1b1b1b),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          ),
          child: _authController.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text('Continue as Guest'),
        ),
      ],
    );
  }

  SizedBox _build10pxSpace() => const SizedBox(height: 10.0);

  Widget _buildLoginWithEmailAndPassword() {
    return Card(
      child: Container(
        height: 175,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: const BoxDecoration(
            // color: const Color(0xff1b1b1b),
            ),
        child: Column(children: [
          // const SizedBox(height: 10.0),
          SizedBox(
            height: 45,
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          _build10pxSpace(),
          SizedBox(
            height: 45,
            child: TextField(
              controller: _passwordController,
              style: const TextStyle(
                  color: Colors.white), // Text color for dark mode
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //       color: Colors
                //           .grey[700]!), // Border color for dark mode
                // ),
              ),

              obscureText: true,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff1b1b1b),
                borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
