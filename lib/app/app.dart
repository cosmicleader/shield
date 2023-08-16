import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/views/pages/volunteers_page.dart';

import 'controllers/volunteer_page_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: VolunteersPage(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<VolunteersController>(() => VolunteersController());
      }),
    );
  }
}
