import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/auth_controller.dart';

import '../themes/colours.dart';

kUpdateUsername() {
  final authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  Get.defaultDialog(
    title: "Update Name",
    content: TextField(
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: kGray.withOpacity(0.25),
        hintText: authController.user.value?.displayName!,
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
    confirm: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => kBlack)),
      onPressed: () {
        authController.updateName(emailController.text);
        authController.update();
      },
      child: Text(
        "Update",
        style: GoogleFonts.inter(color: kBlack),
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
        style: GoogleFonts.inter(color: kBlack),
      ),
    ),
  );
}
