import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/user_posts_controller.dart'; // Create this controller
import 'package:shield/app/views/themes/colours.dart';

import '../../models/resources_model.dart';
import '../../models/volunteer_request.dart'; // Replace with your volunteer model

class UserPostsPage extends StatelessWidget {
  const UserPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserPostsController controller = Get.put(UserPostsController());
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'MY POSTS',
              style: GoogleFonts.inter(
                fontSize: 16, // Adjust the font size as needed
                // fontWeight: FontWeight.bold, // Bold text style
                color: kWhite, // Text color
              ),
            ),
            backgroundColor: kBlack, // Background color of the AppBar
            elevation: 0.0, // No elevation
          ),
          body: Column(
            children: [
              TabBar(
                overlayColor: MaterialStatePropertyAll(kBlack),
                indicator: BoxDecoration(
                  color: kBlack, // Set the background color for the indicator
                ),
                labelColor: kWhite, // Text color for selected tab
                unselectedLabelColor: kGray, //
                unselectedLabelStyle: TextStyle(
                  color: kBlack, // Set the text color for unselected tabs
                ),
                tabs: const [
                  Tab(
                    text: 'Resources',
                  ),
                  Tab(text: 'Volunteers'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ResourceTab(controller: controller),
                    VolunteerTab(controller: controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourceTab extends StatelessWidget {
  final UserPostsController controller;

  const ResourceTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.resources.isEmpty) {
          return const Center(child: Text('No resources posted.'));
        } else {
          return ListView.builder(
            itemCount: controller.resources.length,
            itemBuilder: (context, index) {
              final resource = controller.resources[index] as Resource;
              return ListTile(
                title: Text(resource.title),
                subtitle: Text(resource.location),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit action
                        controller.editResource(resource);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete action
                        controller.deleteResource(resource.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

class VolunteerTab extends StatelessWidget {
  final UserPostsController controller;

  const VolunteerTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.volunteerRequests.isEmpty) {
          return const Center(child: Text('No volunteers posted.'));
        } else {
          return ListView.builder(
            itemCount: controller.volunteerRequests.length,
            itemBuilder: (context, index) {
              final volunteer =
                  controller.volunteerRequests[index] as VolunteerRequest;
              return ListTile(
                title: Text(volunteer.title ?? "Untitiled"),
                subtitle: Text(volunteer.description ?? " "),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit action
                        controller.editVolunteerRequest(volunteer);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete action
                        controller.deleteVolunteerRequest(volunteer.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
