import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/profile_controller.dart';

import '../../controllers/auth_controller.dart';
import '../themes/colours.dart';

kEmailUpdateDialogueBox({required ProfileController controller}) {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  Get.defaultDialog(
    radius: 8,
    title: "Update Email",
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          filled: true,
          fillColor: kGray.withOpacity(0.25),
          hintText: authController.user.value?.email!,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: kOrange),
          ),
        ),
      ),
    ),
    confirm: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => kBlack)),
      onPressed: () {
        authController.updateEmail(emailController.text);
        authController.update();
      },
      child: Text(
        "Update",
        style: GoogleFonts.inter(color: kWhite),
      ),
    ),
    cancel: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => kBlack)),
      onPressed: () {
        Get.back();
      },
      child: Text(
        "Cancel",
        style: GoogleFonts.inter(color: kWhite),
      ),
    ),
  );
}
