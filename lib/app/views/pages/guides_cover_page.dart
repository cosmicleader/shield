import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/views/themes/colours.dart';
import 'package:shield/app/views/widgets/custom_button.dart';

import '../../controllers/guides_cover_controller.dart';

class GuidesCoverPage extends GetView<GuidesCoverController> {
  const GuidesCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeight(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFirstTitle(),
                  buildHeight(10),
                  buildSecondTitle(),
                ],
              ),
              // buildHeight(50),
              buildLogo(),
              // buildHeight(50),
              buildExploreButon(context),
              buildHeight(20)
            ],
          ),
        ),
      ),
    );
  }

  Center buildExploreButon(BuildContext context) {
    return Center(
        child: CustomButton(
      onPressed: () {
        Get.toNamed("/guides");
      },
      title: "Explore",
      kwidth: MediaQuery.of(context).size.width - 40,
      kheight: 55,
    ));
  }

  Image buildLogo() {
    return Image.asset(
      'assets/thumb/guides_cover.png',
    );
  }

  RichText buildFirstTitle() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(fontSize: 24, color: kOrange),
        children: const <TextSpan>[
          TextSpan(text: 'STAY CALM AND ASSESS\nTHE '),
          TextSpan(
              text: 'SITUATION', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Text buildSecondTitle() {
    return Text(
      'Everything You Need to\nKnow to Stay Safe',
      style: GoogleFonts.inter(fontSize: 24, color: kGray),
    );
  }

  SizedBox buildHeight(double height) {
    return SizedBox(
      height: height,
    );
  }
}
