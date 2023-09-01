import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';
import '../controllers/profile_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
