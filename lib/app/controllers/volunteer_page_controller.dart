import 'dart:developer';

import 'package:get/get.dart';

import '../models/volunteer_request.dart';
import '../services/api_client.dart';

class VolunteersController extends GetxController
    with StateMixin<List<VolunteerRequest>> {
  final ApiClient apiClient = ApiClient();
  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    loadMoreData();
  }

  Future<void> loadMoreData() async {
    try {
      final newData = await apiClient.fetchVolunteerRequests(page: currentPage);
      currentPage++;
      change(newData, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('Failed to load data'));
      log('Error loading data: $e');
    }
  }
}
