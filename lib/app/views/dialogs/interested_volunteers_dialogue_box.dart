import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/accepting_volunteer_request_controller.dart';

import '../../models/volunteer_request.dart';
import '../../utils/calculate_time_ago.dart';

// Display a dialog for showing details of an interested volunteer request.
Future<void> kInterestedVolunteerDialogueBox(VolunteerRequest request) async {
  await Get.defaultDialog(
    title: request.title ?? "Untitled",
    titleStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    radius: 8,
    content: buildDialogContent(request),
  );
}

// Build the content of the dialog.
Widget buildDialogContent(VolunteerRequest request) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Display the description of the volunteer request.
      buildDescriptionText(request),
      const SizedBox(height: 16), // Add some vertical spacing.
      // Display the type and time information.
      buildTypeAndTimeRow(request),
      const SizedBox(height: 16), // Add some vertical spacing.
      // Display action buttons (e.g., Join or Request).
      buildActionButtons(request),
    ],
  );
}

// Build the description text widget.
Widget buildDescriptionText(VolunteerRequest request) {
  return Text(
    request.description ?? "",
    style: const TextStyle(
      fontSize: 16,
    ),
  );
}

// Build the row displaying type and time information.
Widget buildTypeAndTimeRow(VolunteerRequest request) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Display the request type (e.g., available).
      Text(
        'Type: ${request.requestType}',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
      // Display the time since the request was posted.
      buildTimeAgoText(request.postedTime ?? DateTime.now()),
    ],
  );
}

// Build a widget showing the time ago from a given DateTime.
Widget buildTimeAgoText(DateTime? postedTime) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      '${calculateTimeAgo(postedTime ?? DateTime.now())}',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),
  );
}

// Build the row containing action buttons (e.g., Join or Request).
Widget buildActionButtons(VolunteerRequest request) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // Cancel button to close the dialog.
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      const SizedBox(width: 16), // Add some horizontal spacing.
      // Button to handle joining or requesting the volunteer opportunity.
      ElevatedButton(
        onPressed: () => handleActionButtonClick(request),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Text(
          request.requestType == "available" ? "Join" : "Request",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

// Handle the click event of the action button (Join or Request).
void handleActionButtonClick(VolunteerRequest request) {
  final acceptVolunteerRequestController =
      Get.put(AcceptVolunteerRequestController());
  Get.back(); // Close the dialog.
  acceptVolunteerRequestController.confirmAction(request.id, request.ownerId);
}
