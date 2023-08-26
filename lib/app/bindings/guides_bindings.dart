import 'package:get/get.dart';

import '../controllers/guides_controller.dart';
import '../services/data_service.dart';

class GuidesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuidesController>(() => GuidesController());
    final DataService dataService = DataService();
    final allListData = dataService.getAllListData();
    Get.put(allListData);
  }
}
