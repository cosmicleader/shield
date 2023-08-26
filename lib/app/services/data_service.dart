import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../models/guides_model.dart';

class DataService {
  final Box<Guides> _guidesBox = Hive.box<Guides>('guidesbox');

  bool isGuidesExist(String id) => _guidesBox.containsKey(id);
//check if the guidesbox is empty or not
  bool isNotEmpty() => 0 != _guidesBox.length;
  void storeListData(Guides data) {
    if (!isGuidesExist(data.id)) {
      _guidesBox.put(data.id, data);
    }
  }

  List<Guides> getAllListData() {
    log('Line 21 Guides page${_guidesBox.values.toList().toString()}');
    return _guidesBox.values.toList();
  }

  Future<void> loadJsonDataAndStoreInHive() async {
    if (_guidesBox.isNotEmpty) {
      // Data is already loaded, no need to reload
      // return;
    }
    try {
      final jsonString = await rootBundle
          .loadString('lib/assets/sample_data/guides_list.json');
      // log("List Data ${jsonString}");
      final data = json.decode(jsonString);
      log("List Data $data");
      final jsonData = data["lists"];
      for (var jsonItem in jsonData) {
        final listData = Guides.fromJson(jsonItem);
        log("List Data $jsonData");
        if (isGuidesExist(listData.id)) {
          // Data is already loaded, no need to reload
          log('id: ${listData.id} already Exists');
          continue;
        }
        storeListData(listData);
        log('data Service line 42${listData.name}');
        log("ID : ${listData.id} | Title : ${listData.id}");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
