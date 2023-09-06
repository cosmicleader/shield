import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/volunteer_request.dart';
import '../services/api_client.dart';
import '../services/firebase_service.dart';

class VolunteersController extends GetxController
    with StateMixin<List<VolunteerRequest>> {
  var name = 'Guest'.obs;
  final ApiClient apiClient = ApiClient();
  final FirebaseService _firebaseService = Get.find();

  // late RxList<VolunteerRequest> requests;

  @override
  void onInit() async {
    super.onInit();
    loadRequests();
  }

  loadRequests() async {
    _firebaseService.getRequestsStream().listen((QuerySnapshot snapshot) async {
      final requests = snapshot.docs.map((doc) {
        var requestData = doc.data() as Map<String, dynamic>;

        return VolunteerRequest(
          id: doc.id,
          ownerId: requestData['ownerId'] ?? '',
          title: requestData['title'] ?? '', // Use the null-aware operator
          description:
              requestData['description'] ?? '', // Use the null-aware operator
          postedTime: DateTime.now(),
          requestType:
              requestData['requestType'] ?? '', // Use the null-aware operator
        );
      }).toList();
      change(requests, status: RxStatus.success());
      update();
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
