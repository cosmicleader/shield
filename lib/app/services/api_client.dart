import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import '../models/volunteer_request.dart';

class ApiClient {
  Future<List<VolunteerRequest>> fetchVolunteerRequests(
      {required int page}) async {
    final jsonStr = await rootBundle
        .loadString('lib/assets/sample_data/volunteers_list.json');
    log("loading data >>>>>>>>>>>>>>>>>>>>>>>\n $jsonStr");
    final List<dynamic> decodedResponse = json.decode(jsonStr);
    return decodedResponse
        .map((json) => VolunteerRequest.fromJson(json))
        .toList();

    // final response = '''
    //   [ ... your sample JSON data ... ]
    // '''; // Replace with your actual API call

    // final List<dynamic> decodedResponse = json.decode(response);
    // return decodedResponse
    //     .map((json) => VolunteerRequest.fromJson(json))
    //     .toList();
  }
}
