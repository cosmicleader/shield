import 'package:get/get.dart';

import '../controllers/volunteer_page_controller.dart';

class VolunteersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VolunteersController>(() => VolunteersController());
  }
}
