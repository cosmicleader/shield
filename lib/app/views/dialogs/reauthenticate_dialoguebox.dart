import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import '../themes/colours.dart';

// Function to reauthenticate the user before performing a sensitive action
void reauthenticateUser(Function? actionToRun) async {
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  // Display a dialog for reauthentication
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
        backgroundColor: MaterialStateColor.resolveWith((states) => kBlack),
      ),
      onPressed: () async {
        final reauthenticated =
            await authController.reauthenticateUser(passwordController.text);

        if (reauthenticated) {
          Get.back(); // Close the reauthentication dialog
          // Execute the action upon successful reauthentication
          actionToRun?.call();
        } else {
          Get.back(); // Close the reauthentication dialog
          // Display an error dialog if reauthentication fails
          Get.defaultDialog(
            title: "Error",
            content: Text(
              "Reauthentication failed.",
              style: GoogleFonts.inter(color: kBlack),
            ),
            confirm: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kBlack),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                "OK",
                style: GoogleFonts.inter(color: kWhite),
              ),
            ),
          );
        }
      },
      child: Text(
        "Reauthenticate",
        style: GoogleFonts.inter(color: kWhite),
      ),
    ),
    cancel: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => kBlack),
      ),
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
