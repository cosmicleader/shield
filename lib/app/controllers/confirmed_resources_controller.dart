import 'dart:developer';

import 'package:get/get.dart';
import 'package:shield/app/models/confirmed_resource.dart';
import 'package:shield/app/services/firebase_service.dart';

class ConfirmedResourcesController extends GetxController
    with StateMixin<List<ConfirmedResource>> {
  RxList<ConfirmedResource> confirmData = <ConfirmedResource>[].obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    fetchConfirmedRequests();
  }

  void fetchConfirmedRequests() async {
    try {
      confirmData.value = await FirebaseService().getConfirmResources();
      log('confirmed Resources data is ${confirmData.toString()}');
      change(confirmData, status: RxStatus.success());
      update();
    } catch (error) {
      change(null, status: RxStatus.error('Error fetching data'));
    }
  }
}
