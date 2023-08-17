import 'package:get/get.dart';

import '../controllers/guides_controller.dart';

class GuidesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuidesController>(() => GuidesController());
  }
}
