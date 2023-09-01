import 'package:get/get.dart';
import 'package:shield/app/controllers/map_controller.dart';

class MapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(() => MapsController());
  }
}
