import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/views/widgets/custom_button.dart';

import '../../models/volunteer_request.dart';
import '../../utils/calculate_time_ago.dart';

Widget buildRequestTile(VolunteerRequest request) {
  return Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            child: Text(
              request.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Type: ${request.requestType}',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            request.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Posted ${calculateTimeAgo(request.postedTime)} ago',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff1b1b1b))),
                onPressed: () {
                  Get.defaultDialog(
                    radius: 8,
                    title: request.title,
                    content: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(request.description),
                          Container(
                            height: 45,
                            // width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Type: ${request.requestType}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                // SizedBox.expand(),
                                Text(
                                  'Posted ${calculateTimeAgo(request.postedTime)} ago',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              CustomButton(
                                title: "Cancel",
                                onPressed: () => Get.back(),
                              ),
                              CustomButton(
                                title: request.requestType == "available"
                                    ? "Join"
                                    : "Request",
                                onPressed: () => Get.snackbar(
                                    "Hi", "Confirmaion has pressed"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text(r"I'm Interested"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
