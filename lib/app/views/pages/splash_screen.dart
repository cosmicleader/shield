import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: controller.obx(
          (data) => Text('Loaded: ${data?['appTitle']}'),
          onLoading: const CircularProgressIndicator(),
          onError: (error) => Text('Error: $error'),
        ),
      ),
    );
  }
}
