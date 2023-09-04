import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shield/app/services/firebase_service.dart';

import '../models/guides_model.dart';

class GuidesController extends GetxController with StateMixin<List<Guides>> {
  final FirebaseService _firebaseService = FirebaseService();

  RxList<String> dropDownOptions = <String>['Earthquake indoor'].obs;
  Rx<Guides>? selectedCategory;
  RxList<Guides> guides = <Guides>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      change(null, status: RxStatus.loading());

      final QuerySnapshot snapshot = await _firebaseService.getGuidesList();

      if (!snapshot.docs.isEmpty) {
        guides.value = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final elementsData = data["elements"] as List<dynamic>;
          final elements = elementsData.map((element) {
            return GuideStep.fromJson(element as Map<String, dynamic>);
          }).toList();

          final guide =
              Guides(id: doc.id, name: data['hazardsName'], elements: elements);
          return guide;
        }).toList();

        selectedCategory?.value = guides.first;
        update();
        change(guides, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error('An error occurred: $e'));
    }
  }

  void handleDropdownSelection(String? newValue) {
    change(null, status: RxStatus.loading());
    if (newValue != null) {
      final selectedGuide = guides.firstWhere(
        (guide) => guide.name == newValue,
        // orElse: () => null,
      );

      selectedCategory?.value = selectedGuide;
      change(guides, status: RxStatus.success());
      update();
    }
  }
}
