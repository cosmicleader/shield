import 'dart:developer';

import 'package:get/get.dart';
import 'package:shield/app/services/firebase_service.dart';

import '../models/confirmed_request.dart';

class ConfirmedRequestsController extends GetxController
    with StateMixin<List<ConfirmedRequest>> {
  RxList<ConfirmedRequest> confirmData = <ConfirmedRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    fetchConfirmedRequests();
  }

  void fetchConfirmedRequests() async {
    try {
      confirmData.value = await FirebaseService().getConfirmedRequests();
      log('confirmed Requests data is ${confirmData.toString()}');
      change(confirmData, status: RxStatus.success());
      update();
    } catch (error) {
      change(null, status: RxStatus.error('Error fetching data'));
    }
  }
}
