import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/views/themes/colours.dart';

import '../../controllers/guides_controller.dart';

class GuidesPage extends GetView<GuidesController> {
  const GuidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildTitle(),
              _buildGuidesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
            return DropdownButton<String>(
              value: controller.selectedCategory?.value.name,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  // controller.changeCategory(newValue);
                  controller.selectedCategory = controller.guides.first.obs;
                  controller.update();
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
    );
  }

  Widget _buildTitle() {
    return Text(
      'WHEN DISASTER STRIKES,\nKNOW TO ESCAPE',
      style: GoogleFonts.inter(
        color: kBlack.withOpacity(0.5),
        fontSize: 24,
      ),
    );
  }

  Widget _buildGuidesList() {
    return Expanded(
      child: controller.obx(
        (state) {
          final selectedGuide = controller.selectedCategory?.value;
          return ListView.builder(
            itemCount: selectedGuide?.elements.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _buildGuideItem(selectedGuide, index);
            },
          );
        },
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildGuideItem(selectedGuide, int index) {
    final guideItem = selectedGuide?.elements[index] ??
        controller.guides.first.elements[index];

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
      decoration: BoxDecoration(
        color: kBlack.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 261,
            decoration: BoxDecoration(
              color: kBlack.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${guideItem.step}',
                style: GoogleFonts.inter(
                  color: kBlack.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // You can add any other icon or decoration here if needed
            ],
          ),
          const SizedBox(height: 10),
          Text(
            guideItem.title,
            style: GoogleFonts.inter(
              color: kBlack,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            guideItem.description,
            style: GoogleFonts.inter(
              color: kBlack.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
