import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';

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
            const SizedBox(
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
