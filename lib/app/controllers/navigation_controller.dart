import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  void setIndex(int index) {
    currentIndex.value = index;
    update();
  }

  void showModalBottomSheet() {
    Get.bottomSheet(
      const SizedBox(
        height: 200,
        child: Center(
          child: Text('Modal Bottom Sheet Content'),
        ),
      ),
    );
  }
}
