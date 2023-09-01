import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/views/themes/colours.dart';
import 'package:shield/app/views/widgets/custom_button.dart';

import '../../controllers/requests_controller.dart';

kRequestVolunteerDialog() {
  final RequestController dataController = Get.put(RequestController());

  Get.bottomSheet(
    Container(
      // height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: kBlack,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 45,
            child: Center(
              child: Text(
                "REQUEST VOLUNTEERS",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, color: kWhite),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: dataController.titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kWhite,
                      hintText: 'Enter a title...',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
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
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: dataController.descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kWhite,
                      hintText: 'Write a description...',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide(color: kOrange),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  kwidth: double.infinity,
                  color: kWhite,
                  kheight: 55,
                  title: 'Post Request',
                  onPressed: () {
                    dataController.uploadData();
                    dataController.titleController.clear();
                    dataController.descriptionController.clear();
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
          ),
        ],
      ),
    ),
  );
}
