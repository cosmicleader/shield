import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  @override
  void onInit() {
    super.onInit();
    loadAppConfig();
  }

  Future<void> loadAppConfig() async {
    try {
      final String data =
          await rootBundle.loadString('lib/assets/config_data/app_config.json');
      final appConfigData = json.decode(data);
      change(appConfigData, status: RxStatus.success());
      if (appConfigData != null) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offNamed('/navigation'); // Navigate to '/home' route
        });
      }
    } catch (e) {
      log("Error loading app_config.json: $e");
      change(null, status: RxStatus.error("Error loading app_config.json"));
    }
  }
}
