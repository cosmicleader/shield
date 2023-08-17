// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/volunteer_request.dart';
import '../../utils/calculate_time_ago.dart';

Future<dynamic> kInterestedVolunteerDialogueBox(VolunteerRequest request) {
  return Get.defaultDialog(
    radius: 8,
    title: request.title,
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(request.description),
        ),
        _build10PIXHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Type: ${request.requestType}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                'Posted ${calculateTimeAgo(request.postedTime)} ago',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        _build10PIXHeight(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff1b1b1b))),
              child: const Text(
                "Cancel",
              ),
            ),
            _build10PixWidth(),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar("Hi", "Confirmation has been pressed");
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff1b1b1b))),
              child: Text(
                request.requestType == "available" ? "Join" : "Request",
              ),
            ),
            _build10PixWidth(),
          ],
        ),
      ],
    ),
  );
}

SizedBox _build10PIXHeight() => const SizedBox(height: 10);

SizedBox _build10PixWidth() {
  return const SizedBox(
    width: 10,
  );
}
