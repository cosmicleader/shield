import 'package:flutter/material.dart';

import '../../models/volunteer_request.dart';
import '../../utils/calculate_time_ago.dart';
import '../dialogs/interested_volunteers_dialogue_box.dart';

class RequestTile extends StatelessWidget {
  final VolunteerRequest request;

  // Constructor for the RequestTile widget.
  const RequestTile({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build a card containing a list tile with the request information.
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: buildTitle(), // Build the title section.
        subtitle: buildSubtitle(), // Build the subtitle section.
      ),
    );
  }

  // Build the title section of the request tile.
  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            request.title ??
                "Untitled", // Display the title or "Untitled" if null.
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          'Type: ${request.requestType}', // Display the request type.
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Build the subtitle section of the request tile.
  Widget buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          request.description ??
              "", // Display the description or an empty string if null.
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Posted ${calculateTimeAgo(request.postedTime ?? DateTime.now())} ago', // Display the time since posting.
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff1b1b1b)),
            ),
            onPressed: () {
              // Open a dialogue box for interested volunteers.
              kInterestedVolunteerDialogueBox(request);
            },
            child: const Text("I'm Interested"),
          ),
        ),
      ],
    );
  }
}
