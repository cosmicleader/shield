import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: (MediaQuery.of(context).size.height * 0.3),
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: const Color(0xff1b1b1b),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(children: [
                  // const SizedBox(height: 10.0),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _passwordController,
                      style: const TextStyle(
                          color: Colors.white), // Text color for dark mode
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        border: OutlineInputBorder(),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff1b1b1b),
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: _authController.isLoading.value
                  //       ? null
                  //       : () {
                  //           final email = _emailController.text.trim();
                  //           final password = _passwordController.text.trim();
                  //           _authController.signInWithEmailAndPassword(
                  //               email, password);
                  //         },
                  //   child: _authController.isLoading.value
                  //       ? const CircularProgressIndicator(
                  //           valueColor:
                  //               AlwaysStoppedAnimation<Color>(Colors.white),
                  //         )
                  //       : const Text(
                  //           'Login',
                  //           style: TextStyle(color: Color(0xff1b1b1b)),
                  //         ),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 40.0, vertical: 12.0),
                  //   ),
                  // ),
                ]),
              ),
              const SizedBox(height: 10.0),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'OR',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                ),
                child: _authController.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controllers/auth_controller.dart';

// class LoginPage extends StatelessWidget {
//   final AuthController _authController = Get.put(AuthController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _authController.isLoading.value
//                   ? null
//                   : _authController.signInWithGoogle,
//               child: _authController.isLoading.value
//                   ? const CircularProgressIndicator()
//                   : const Text('Sign in with Google'),
//             ),

//             // Other login methods buttons
//           ],
//         ),
//       ),
//     );
//   }
// }
