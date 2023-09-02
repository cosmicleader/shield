import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/controllers/map_controller.dart';
import 'package:shield/app/controllers/profile_controller.dart';
import 'package:shield/app/views/dialogs/email_update_dialoguebox.dart';
import 'package:shield/app/views/themes/colours.dart';
import 'package:shield/app/views/widgets/custom_button.dart';

import '../dialogs/reauthenticate_dialoguebox.dart';
import '../dialogs/update_name_dialogue.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final mapsController = Get.put(MapsController());

    final user = authController.user.value;
    final displayName = user?.displayName ?? 'Guest';
    final email = user?.email;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              _buildHeight(20),
              _buildProfileAvatar(user),
              _buildNameCard(displayName),
              _buildHeight(10),
              _buildEmailCard(email),
              _buildHeight(10),
              _buildSignInSignOutButton(authController, user, context),
              _buildHeight(10),
              _buildChooseLocationButton(mapsController, context),
              _buildHeight(10),
              _buildAlertMyLocationCard(controller, context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildHeight(double height) => SizedBox(height: height);

  Widget _buildProfileAvatar(User? user) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180),
        gradient: LinearGradient(colors: [kRed, kOrange]),
      ),
      child: user?.photoURL != null
          ? CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(user!.photoURL!),
            )
          : Icon(
              Icons.person,
              size: 50,
              color: kWhite,
            ),
    );
  }

  Widget _buildNameCard(String displayName) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kGray.withOpacity(0.5),
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Name:",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: kBlack,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              displayName,
              style: GoogleFonts.inter(
                color: kBlack,
              ),
            ),
            IconButton(
              color: kGray,
              onPressed: () {
                // Implement the edit name functionality here
                updateUsername();
                controller.update();
              },
              icon: const Icon(
                Icons.edit_square,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailCard(String? email) {
    return email != null
        ? Container(
            height: 45,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kGray.withOpacity(0.5),
            ),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  Text(
                    "Email:",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(email),
                  IconButton(
                    color: kGray,
                    onPressed: () {
                      // Implement email update functionality here
                      reauthenticateUser(
                          kEmailUpdateDialogueBox(controller: controller));
                      controller.update();
                    },
                    icon: const Icon(
                      Icons.edit_square,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Text("Please Sign in");
  }

  Widget _buildSignInSignOutButton(
      AuthController authController, User? user, BuildContext context) {
    return CustomButton(
      kwidth: MediaQuery.of(context).size.width - 40,
      kheight: 45,
      title: user != null ? 'Logout' : 'Sign in',
      onPressed: () {
        if (user != null) {
          authController.signOut();
        } else {
          Get.toNamed('/login');
        }
      },
    );
  }

  Widget _buildChooseLocationButton(
      MapsController mapsController, BuildContext context) {
    return CustomButton(
      kwidth: MediaQuery.of(context).size.width - 40,
      kheight: 45,
      title: 'Choose Location',
      onPressed: () {
        // Implement location selection functionality here
        AlertDialog(
          title: const Text('Example'),
          content: PlacesAutocomplete(
            apiKey: "AIzaSyAFY6EGZliOQ4Ovc_SD4x8BpFkerPmse6U",
            searchHintText: "Search for a place",
            mounted: true,
            hideBackButton: true,
            initialValue: mapsController.initialValue.value,
            onSuggestionSelected: (value) {
              mapsController.updateInitialValue(value);
              mapsController.update();
            },
            onGetDetailsByPlaceId: mapsController.updateAddress,
          ),
        );
      },
    );
  }

  Widget _buildAlertMyLocationCard(
      ProfileController controller, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.showAlert();
      },
      child: Card(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: [kRed, kOrange]),
          ),
          child: Center(
            child: Text(
              "Alert My Location",
              style: GoogleFonts.inter(color: kWhite),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:map_location_picker/map_location_picker.dart';
// import 'package:shield/app/controllers/auth_controller.dart';
// import 'package:shield/app/views/dialogs/reauthenticate_dialoguebox.dart';
// import 'package:shield/app/views/dialogs/update_name_dialogue.dart';
// import 'package:shield/app/views/themes/colours.dart';
// import 'package:shield/app/views/widgets/custom_button.dart';

// import '../../controllers/map_controller.dart';
// import '../../controllers/profile_controller.dart';
// import '../dialogs/email_update_dialoguebox.dart';

// class ProfilePage extends GetView<ProfileController> {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 margin: const EdgeInsets.all(20),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(180),
//                   gradient: LinearGradient(colors: [kRed, kOrange]),
//                 ),
//                 child: GetBuilder<AuthController>(
//                   init: AuthController(),
//                   initState: (_) {},
//                   builder: (authController) {
//                     return authController.user.value?.photoURL != null
//                         ? CircleAvatar(
//                             radius: 100,
//                             backgroundImage: NetworkImage(
//                                 authController.user.value!.photoURL ?? ''),
//                           )
//                         : Icon(
//                             Icons.person,
//                             size: 50,
//                             color: kWhite,
//                           );
//                   },
//                 ),
//               ),
//               Container(
//                 height: 45,
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: kGray.withOpacity(0.5),
//                 ),
//                 child: Card(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Name:",
//                         style: GoogleFonts.inter(
//                             fontWeight: FontWeight.bold, color: kBlack),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       GetX<AuthController>(
//                         init: AuthController(),
//                         initState: (_) {},
//                         builder: (authController) {
//                           return Text(
//                             authController.user.value?.displayName ?? 'Guest',
//                             style: GoogleFonts.inter(
//                               color: kBlack,
//                             ),
//                           );
//                         },
//                       ),
//                       IconButton(
//                         color: kGray,
//                         onPressed: () {
//                           kUpdateUsername();
//                         },
//                         icon: const Icon(
//                           Icons.edit_square,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Email
//               const SizedBox(
//                 height: 10,
//               ),
//               GetBuilder<AuthController>(
//                 init: AuthController(),
//                 initState: (_) {},
//                 builder: (authController) {
//                   return authController.user.value != null
//                       ? Container(
//                           height: 45,
//                           margin: const EdgeInsets.symmetric(horizontal: 20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: kGray.withOpacity(0.5),
//                           ),
//                           child: Card(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   "Email:",
//                                   style: GoogleFonts.inter(
//                                       fontWeight: FontWeight.bold,
//                                       color: kBlack),
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(authController.user.value!.email!),
//                                 IconButton(
//                                   color: kGray,
//                                   onPressed: () {
//                                     kReathenticate(kEmailUpdateDialogueBox(
//                                         controller: controller));
//                                     controller.update();
//                                   },
//                                   icon: const Icon(
//                                     Icons.edit_square,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : const Text("Please Sign in");
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               GetBuilder<AuthController>(
//                 init: AuthController(),
//                 initState: (_) {},
//                 builder: (authController) {
//                   return authController.user.value != null
//                       ? CustomButton(
//                           kwidth: MediaQuery.of(context).size.width - 40,
//                           kheight: 45,
//                           title: 'Logout',
//                           onPressed: () {
//                             authController.signOut();
//                             controller.update();
//                             authController.update();
//                           },
//                         )
//                       : CustomButton(
//                           kwidth: MediaQuery.of(context).size.width - 40,
//                           kheight: 45,
//                           title: 'Sign in',
//                           onPressed: () {
//                             Get.toNamed('/login');
//                             controller.update();
//                             authController.update();
//                           });
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               GetBuilder<MapsController>(
//                 init: MapsController(),
//                 initState: (_) {},
//                 builder: (mapsController) {
//                   return CustomButton(
//                     kwidth: MediaQuery.of(context).size.width - 40,
//                     kheight: 45,
//                     title: 'Choose Location',
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return GetBuilder<MapsController>(
//                             init: MapsController(),
//                             initState: (_) {},
//                             builder: (mapsController) {
//                               return AlertDialog(
//                                 title: const Text('Example'),
//                                 content: PlacesAutocomplete(
//                                   apiKey:
//                                       "AIzaSyAFY6EGZliOQ4Ovc_SD4x8BpFkerPmse6U",
//                                   searchHintText: "Search for a place",
//                                   mounted: true,
//                                   hideBackButton: true,
//                                   initialValue:
//                                       mapsController.initialValue.value,
//                                   onSuggestionSelected: (value) {
//                                     mapsController.updateInitialValue(value);
//                                     mapsController.update();
//                                   },
//                                   onGetDetailsByPlaceId:
//                                       mapsController.updateAddress,
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),

//               InkWell(
//                 onTap: () {
//                   controller.showAlert();
//                 },
//                 child: Card(
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.2,
//                     width: MediaQuery.of(context).size.width - 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       // color: Colors.amber,
//                       gradient: LinearGradient(colors: [kRed, kOrange]),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Alert My Location",
//                         style: GoogleFonts.inter(color: kWhite),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
