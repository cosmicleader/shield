import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/views/themes/colours.dart';
import 'package:shield/app/views/widgets/custom_button.dart';

import '../../controllers/signup_controller.dart';

class SignUpScreen extends GetWidget<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text('Sign Up')),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGray.withOpacity(0.25),
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!GetUtils.isEmail(value ?? 'null')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    buildHeight10(),
                    TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGray.withOpacity(0.25),
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a password';
                        } else if ((value?.length ?? 1) < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    buildHeight10(),
                    TextFormField(
                      controller: controller.displayNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGray.withOpacity(0.25),
                        hintText: 'Display Name',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your display name';
                        }
                        return null;
                      },
                    ),
                    buildHeight10(),
                    TextFormField(
                      controller: controller.phoneNumberController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGray.withOpacity(0.25),
                        hintText: 'Phone Number',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your phone number';
                        }
                        // You can add more phone number validation if needed
                        return null;
                      },
                    ),
                    buildHeight10(),
                    TextFormField(
                      controller: controller.dateOfBirthController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kGray.withOpacity(0.25),
                        hintText: 'Date of Birth',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        controller.selectDate(context);
                      },
                    ),
                    buildHeight10(),
                    CustomButton(
                        kwidth: MediaQuery.of(context).size.width - 40,
                        kheight: 55,
                        onPressed: controller.pickImage,
                        title: 'Pick Profile Picture'),
                    Obx(() => controller.profilePicture.value != null
                        ? Image.file(controller.profilePicture.value!)
                        : Container()),
                    buildHeight10(),
                    CustomButton(
                        kwidth: MediaQuery.of(context).size.width - 40,
                        kheight: 55,
                        onPressed: () {
                          if (controller.formKey.currentState?.validate() ??
                              false) {
                            controller.signUp();
                          }
                        },
                        title: 'Sign Up'),
                  ],
                ),
              ),
            ),
            //Back button
            Positioned(
              top: 20,
              left: 20,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color(0xff1b1b1b),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                          color: kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildHeight10() {
    return const SizedBox(
      height: 10,
    );
  }
}
