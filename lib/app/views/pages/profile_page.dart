import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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

import '../../services/audio_services.dart';
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
              GetBuilder<AlertController>(
                init: AlertController(),
                initState: (_) {},
                builder: (alertController) {
                  return alertController.status.isSuccess
                      ? _buildAlertMyLocationStopCard(alertController, context)
                      : _buildAlertMyLocationStartCard(
                          alertController, context);
                },
              )
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

  Widget _buildAlertMyLocationStopCard(
      AlertController controller, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.stopAlert();
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
              "Stop Alert",
              style: GoogleFonts.inter(color: kWhite),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlertMyLocationStartCard(
      AlertController controller, BuildContext context) {
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
  // Widget _buildAlertMyLocationCard(
  //     ProfileController controller, BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       controller.showAlert();
  //     },
  //     child: Card(
  //       child: Container(
  //         height: MediaQuery.of(context).size.height * 0.2,
  //         width: MediaQuery.of(context).size.width - 40,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           gradient: LinearGradient(colors: [kRed, kOrange]),
  //         ),
  //         child: Center(
  //           child: Text(
  //             "Alert My Location",
  //             style: GoogleFonts.inter(color: kWhite),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:audioplayers/audioplayers.dart';

class AlertController extends GetxController with StateMixin {
  final alertService = AlertService();
  final interval = 1.obs;
  final times = 1.obs;
  final recipient = ''.obs;
  final disabled = false.obs;
  final soundFile = ''.obs;
  RxBool isPlaying = false.obs;
  final player = AudioPlayer();
  Timer? _timer;

  void showAlert() {
    if (disabled.value) return;

    _sendSMS();
    alertService.playSound();
    _timer = Timer.periodic(
      Duration(minutes: interval.value),
      (timer) {
        if (timer.tick >= times.value) {
          timer.cancel();
        } else {
          _sendSMS();
          alertService.playSound();
        }
      },
    );
    change(null, status: RxStatus.success());
  }

  void stopAlert() {
    _timer?.cancel();
    change(null, status: RxStatus.empty());
  }

  //return bool wheather if it's playing or not
//  isPlaying.value = _isPlaying();
  bool _isPlaying() {
    return player.state == PlayerState.playing;
  }

  void _sendSMS() {
    // Use GetX service to send SMS to recipient with current location
    // Get.find<SmsService>().sendSms(recipient.value, 'My current location is ...');
  }

  // void _playSound() async {
  //   // Play the alert sound file at the current volume
  //   // final player = AudioCache();

  //   // player.play(soundFile.value);

  //   await player.play(AssetSource('alert_sound.mp3'));
  // }
}
