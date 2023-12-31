import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/views/pages/chat_page.dart';
import 'package:shield/app/views/pages/guides_cover_page.dart';
import 'package:shield/app/views/pages/profile_page.dart';
import 'package:shield/app/views/pages/resources_page.dart';
import 'package:shield/app/views/pages/volunteers_page.dart';
import 'package:shield/app/views/themes/colours.dart';
import 'package:shield/app/views/themes/icons.dart';

import '../../controllers/navigation_controller.dart';

// ignore: must_be_immutable
class NavigationBar extends GetView<NavigationController> {
  NavigationBar({super.key});

  final iconList = <IconData>[
    kVolunteerPage,
    kGuidesPage,
    kResourcesPage,
    kProfilePage,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavigationController>(
        init: NavigationController(),
        initState: (_) {},
        builder: (controller) {
          return buildCustomNavigator(controller.currentIndex.value);
        },
      ), //destination screen
      floatingActionButton: FloatingActionButton(
        backgroundColor: kRed,
        onPressed: () {
          final authController = Get.put(AuthController());
          authController.isAuthenticated
              ? Get.to(() => ChatPage(), transition: Transition.downToUp)
              : Get.toNamed('/login');
        },

        child: const Icon(Icons.chat_rounded),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<NavigationController>(
        init: NavigationController(),
        initState: (_) {},
        builder: (controller) {
          return AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: controller.currentIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => controller.setIndex(index),
            //other params
          );
        },
      ),
    );
  }
}

buildCustomNavigator(currentIndex) {
  switch (currentIndex) {
    case 0:
      return const VolunteersPage();
    case 1:
      return const GuidesCoverPage();
    // case 2:
    //   return Container(
    //     color: Colors.amberAccent,
    //   );
    case 2:
      return const ResourcesPage();
    case 3:
      return const ProfilePage();
    default:
      return const VolunteersPage();
  }
}


//================================
