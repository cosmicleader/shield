import 'dart:developer';

import 'package:get/get.dart';
import 'package:shield/app/services/data_service.dart';

import '../models/guides_model.dart';

class GuidesController extends GetxController with StateMixin<List<Guides>> {
  final _services = DataService();
  RxList<String> dropDownOptions = ['List 1', 'List 2'].obs;
  final Map<String, Guides> categoryMap = {}; // Create an empty HashMap
  List<Guides> allListData = [];
  // late var dropDownOptions = <String>[];

  /// Need To create a new controller for the drop down menu since this one only loads the list view builder
  late Rx<Guides> selectedCategory; // Declare selectedCategory as Rx

  @override
  void onInit() {
    selectedCategory = Guides(id: "list_1", name: "List 1", elements: []).obs;
    loadData();
    final dropDownOptions = allListData.map((guide) => guide.name).toList();
    update();
    super.onInit();
  }

  void loadData() async {
    change(null, status: RxStatus.loading());
    update();
    final allListData = _services.getAllListData();
    log("allListData ${allListData.first.name}");

    // selectedCategory.value = categoryMap[selectedCategory.value.name] ??
    //     categoryMap[allListData.first.name]!;
    if (allListData.isNotEmpty) {
      for (Guides guides in allListData) {
        categoryMap[guides.name] = guides;
      }
      log('one map ${categoryMap[selectedCategory.value.name]}');
      selectedCategory.value = categoryMap[selectedCategory.value.name]!;

      change(allListData, status: RxStatus.success());
      log("data loading completed in guides controller");
      update();
    } else {
      change(null, status: RxStatus.empty());
      update();
    }
  }

  void changeCategory(String newCategory) {
    if (categoryMap.containsKey(newCategory)) {
      selectedCategory.value = categoryMap[newCategory]!;
      update();
    }
  }
}



// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:shield/app/services/data_service.dart';

// import '../models/guides_model.dart';

// class GuidesController extends GetxController {
//   var selectedCategory =
//       Guides(id: "000", name: "Select an option", elements: []).obs;

//   Map<String, Guides> categoryMap = {}; // Create an empty HashMap
//   final _services = DataService();

//   final List<Guides> allListData = Get.find<List<Guides>>();
//   loadHashMap() async {
//     _services.getAllListData();
//     if (_services.isNotEmpty()) {
//       // Populate the HashMap with list names as keys and ListData as values
//       for (Guides guides in allListData) {
//         categoryMap[guides.name] = guides;
//       }
//       log("HashMap Is Finished ${categoryMap.toString()}");
//     }
//   }

//   @override
//   void onInit() {
//     _services.loadJsonDataAndStoreInHive();

//     super.onInit();
//   }

//   Guides? getDataList(String listName) {
//     if (categoryMap.containsKey(listName)) {
//       return categoryMap[listName];
//     }
//     return null;
//   }

//   void changeCategory(String newCategory) {
//     if (categoryMap.containsKey(newCategory)) {
//       selectedCategory.value = categoryMap[newCategory]!;
//       update();
//     }
//   }
// }
