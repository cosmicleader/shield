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
          (data) => const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  value: null,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff1b1b1b)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Please Wait...'),
            ],
          ),
          onLoading: const CircularProgressIndicator(color: Color(0xff1b1b1b)),
          onError: (error) => Text('Error: $error'),
        ),
      ),
    );
  }
}
