import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import '../themes/colours.dart';

// Function to display a dialog for updating the user's name
void updateUsername() {
  // Get the AuthController instance using Get.find
  final authController = Get.find<AuthController>();

  // Create a TextEditingController for the name input field
  final TextEditingController nameController = TextEditingController();

  Get.defaultDialog(
    radius: 8,
    title: "Update Name",
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 45,
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          filled: true,
          fillColor: kGray.withOpacity(0.25),
          hintText: authController.user.value?.displayName ??
              '', // Display current name as a hint
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
        backgroundColor: MaterialStateColor.resolveWith((states) => kBlack),
      ),
      onPressed: () {
        // Get the new name from the text field
        final newName = nameController.text;

        // Check if the new name is not empty before updating
        if (newName.isNotEmpty) {
          authController.updateName(newName);
          Get.back(); // Close the dialog
        }
      },
      child: Text(
        "Update",
        style: GoogleFonts.inter(color: kWhite),
      ),
    ),
    cancel: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => kBlack),
      ),
      onPressed: () {
        Get.back(); // Close the dialog without making any changes
      },
      child: Text(
        "Cancel",
        style: GoogleFonts.inter(color: kWhite),
      ),
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shield/app/controllers/auth_controller.dart';

// import '../themes/colours.dart';

// kUpdateUsername() {
//   final authController = Get.put(AuthController());
//   final TextEditingController emailController = TextEditingController();
//   Get.defaultDialog(
//     radius: 8,
//     title: "Update Name",
//     content: Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       height: 45,
//       // decoration: BoxDecoration(
//       // color: kGray.withOpacity(0.25),
//       // borderRadius: BorderRadius.circular(8.0),
//       // ),
//       child: TextField(
//         controller: emailController,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: kGray.withOpacity(0.25),
//           hintText: authController.user.value?.displayName!,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(color: kOrange),
//           ),
//         ),
//       ),
//     ),
//     confirm: ElevatedButton(
//       style: ButtonStyle(
//           backgroundColor: MaterialStateColor.resolveWith((states) => kBlack)),
//       onPressed: () {
//         authController.updateName(emailController.text);
//         authController.update();
//       },
//       child: Text(
//         "Update",
//         style: GoogleFonts.inter(color: kWhite),
//       ),
//     ),
//     cancel: ElevatedButton(
//       style: ButtonStyle(
//           backgroundColor: MaterialStateColor.resolveWith((states) => kBlack)),
//       onPressed: () {
//         Get.back();
//       },
//       child: Text(
//         "Cancel",
//         style: GoogleFonts.inter(color: kWhite),
//       ),
//     ),
//   );
// }
