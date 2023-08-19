import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  LoginPage({super.key});

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
                              color: Color(0xFFffffff),
                              fontSize: 16,
                            ),
                          )),
                        ),
                        // temp()
                      ],
                    ),
                  ),
                ),
                _buildSignupButton(),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 10),
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
                  Text(
                    "Back",
                    style: TextStyle(
                      color: Color(0xFf1b1b1b), // Use the color code here
                      fontSize: 16, // Set the desired font size
                      // You can also customize other text styles here
                    ),
                  ),
                ],
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
}

class LoginForum extends GetView<LoginController> {
  const LoginForum({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 175,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: const BoxDecoration(
            // color: const Color(0xff1b1b1b),
            ),
        child: Form(
          key: controller.formKey,
          child: Column(children: [
            // const SizedBox(height: 10.0),
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: controller.validateEmail,
              ),
            ),
            // _build10pxSpace(),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: controller.passwordController,
                style: const TextStyle(
                    color: Color(0xff1b1b1b)), // Text color for dark mode
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: controller.validatePassword,

                obscureText: true,
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: controller.submitForm,
              child: Container(
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
            ),
          ]),
        ),
      ),
    );
  }
}
