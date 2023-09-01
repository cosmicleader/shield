import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/auth_controller.dart';

import '../themes/colours.dart';

// import '../../controllers/profile_controller.dart';

kReathenticate(Function? run) async {
  TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  Get.defaultDialog(
    radius: 8,
    title: "Reauthenticate",
    content: Column(
      children: [
        const Text("Please enter your password to continue:"),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: kGray.withOpacity(0.25),
            hintText: 'Password',
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
      ],
    ),
    confirm: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => kBlack)),
      onPressed: () async {
        bool reauthenticated =
            await authController.reauthenticateUser(passwordController.text);
        if (reauthenticated) {
          Get.back(); // Close the reauthentication dialog
          // Replace with your action upon successful reauthentication
          // For example, you can show the email update dialog here
          // showEmailUpdateDialog();
          run;
        } else {
          Get.back(); // Close the reauthentication dialog
          Get.defaultDialog(
            title: "Error",
            content: Text(
              "Reauthentication failed.",
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
      },
      child: Text(
        "Reauthenticate",
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
