import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/views/themes/colours.dart';

import '../../controllers/guides_controller.dart';

class GuidesPage extends GetView<GuidesController> {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const BackButton(),
                      Text(
                        'Back',
                        style: GoogleFonts.inter(color: kBlack),
                      ),
                    ],
                  ),
                  controller.obx(
                    (state) {
                      log(controller.categoryMap.values.toString());
                      return DropdownButton<String>(
                        value: controller.selectedCategory.value.name,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.changeCategory(newValue);
                          }
                        },
                        // ignore: invalid_use_of_protected_member
                        items: controller.dropDownOptions.value
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    },
                    onLoading: const Center(child: CircularProgressIndicator()),
                    onError: (error) => Center(child: Text('Error: $error')),
                  ),
                ],
              ),
              Text(
                'WHEN DISASTER STRIKES,\nKNOW TO ESCAPE',
                style: GoogleFonts.inter(
                    color: kBlack.withOpacity(0.5), fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: controller.obx(
                  (state) {
                    final selectedGuide = controller.selectedCategory.value;
                    return ListView.builder(
                      itemCount: selectedGuide.elements.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                              left: 0, right: 0, top: 0, bottom: 10),
                          decoration: BoxDecoration(
                            color: kBlack.withOpacity(0.1),
                            //MAKE EDGES 8px curve
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 261,
                                // width: 20,
                                // width: 20,
                                decoration: BoxDecoration(
                                  color: kBlack.withOpacity(0.1),
                                  //MAKE EDGES 8px curve
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Step: ${selectedGuide.elements[index].step}',
                                style: GoogleFonts.inter(
                                    color: kBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                selectedGuide.elements[index].description,
                                style: GoogleFonts.inter(
                                    color: kBlack.withOpacity(0.5),
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        );
                        // return ListTile(
                        //   title: Text(
                        //     'Step: ${selectedGuide.elements[index].step}',
                        //   ),
                        //   subtitle:
                        //       Text(selectedGuide.elements[index].description),
                        // );
                      },
                    );
                  },
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onError: (error) => Center(child: Text('Error: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
