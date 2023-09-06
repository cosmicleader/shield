import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/models/volunteer_request.dart';
import 'package:shield/app/services/firebase_service.dart';

import '../models/resources_model.dart';

class UserPostsController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final RxList<Resource> resources = <Resource>[].obs;
  final authController = Get.put(AuthController());

  final RxList<VolunteerRequest> volunteerRequests = <VolunteerRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch user resources and volunteer requests when the controller is initialized.
    loadData();
  }

  loadData() async {
    await fetchUserResources();
    await fetchUserVolunteerRequests();
  }

  Future fetchUserResources() async {
    final resourceDocs =
        await _firebaseService.getMyResources(authController.getUID);
    // resources.assignAll(resourceDocs.map((doc) => Resource.fromFirestore(doc)));
    resources.value = resourceDocs.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final List<String> requests = List<String>.from(data['requests']);
      return Resource(
        id: doc.id,
        ownerId: data['ownerId'],
        title: data['title'],
        type: data['type'],
        location: data['location'],
        isAvailable: data['isAvailable'],
        requests: requests,
      );
    }).toList();
  }

  Future<void> fetchUserVolunteerRequests() async {
    final requestDocs =
        await _firebaseService.getMyVolunteerRequests(authController.getUID);
    // volunteerRequests.assignAll(
    //     requestDocs.map((doc) => VolunteerRequest.fromFirestore(doc)));
    volunteerRequests.value = requestDocs.docs.map((doc) {
      var requestData = doc.data() as Map<String, dynamic>;

      return VolunteerRequest(
        id: doc.id,
        ownerId: requestData['ownerId'],
        title: requestData['title'] ?? '', // Use the null-aware operator
        description:
            requestData['description'] ?? '', // Use the null-aware operator
        postedTime: DateTime.now(),
        requestType:
            requestData['requestType'] ?? '', // Use the null-aware operator
      );
    }).toList();
  }

  Future<void> editResource(Resource resource) async {
    await _firebaseService.updateResource(resource.id, resource);
    // You can also update the local resources list if needed.
  }

  Future<void> editVolunteerRequest(VolunteerRequest request) async {
    await _firebaseService.updateVolunteer(request.id, request);
    // You can also update the local volunteerRequests list if needed.
  }

  Future<void> deleteResource(String resourceId) async {
    await _firebaseService.deleteResource(resourceId);
    await fetchUserResources();
    update();
    // Remove the deleted resource from the local resources list, if needed.
  }

  Future<void> deleteVolunteerRequest(String requestId) async {
    await _firebaseService.deleteVolunteer(requestId);

    await fetchUserVolunteerRequests();
    update();
    // Remove the deleted volunteer request from the local volunteerRequests list, if needed.
  }
}
