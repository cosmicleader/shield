import 'package:flutter/material.dart';

import '../../models/volunteer_request.dart';
import '../../utils/calculate_time_ago.dart';
import '../dialogs/interested_volunteers_dialogue_box.dart';

Widget buildRequestTile(VolunteerRequest request) {
  return Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
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
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff1b1b1b))),
                onPressed: () {
                  kInterestedVolunteerDialogueBox(request);
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
