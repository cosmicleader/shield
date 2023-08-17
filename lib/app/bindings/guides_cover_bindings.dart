import 'package:get/get.dart';

import '../controllers/guides_cover_controller.dart';

class GuidesCoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuidesCoverController>(() => GuidesCoverController());
  }
}
