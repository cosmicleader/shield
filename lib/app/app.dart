import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.volunteers,
      getPages: AppPages.routes,
    );
  }
}
