import 'package:get/get.dart';

import '../controllers/confirmed_requests_controller.dart';
import '../controllers/confirmed_resources_controller.dart';
import '../services/firebase_service.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmedRequestsController>(
        () => ConfirmedRequestsController());
    Get.lazyPut<ConfirmedResourcesController>(
        () => ConfirmedResourcesController());

    Get.lazyPut<FirebaseService>(() => FirebaseService());
  }
}
