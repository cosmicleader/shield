import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/confirmed_requests_controller.dart';
import 'package:shield/app/controllers/confirmed_resources_controller.dart';
import 'package:shield/app/models/confirmed_resource.dart';
import '../../models/confirmed_request.dart';
import '../themes/colours.dart';

class NotificationPage extends StatelessWidget {
  final ConfirmedRequestsController requestsController =
      Get.put(ConfirmedRequestsController());
  final ConfirmedResourcesController resourcesController =
      Get.put(ConfirmedResourcesController());

  NotificationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(fontSize: 16),
        ),
        backgroundColor: kBlack,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Requests
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Resources',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                resourcesController.obx(
                  (state) {
                    if (state == null) {
                      // Display a loading indicator when data is being fetched
                      return Center(child: CircularProgressIndicator());
                    } else if (state.isEmpty) {
                      // Display a message when no data is available
                      return Center(child: Text('No data available'));
                    } else {
                      // Display the list of volunteer requests
                      return ListView.builder(
                        shrinkWrap:
                            true, // Ensure the ListView doesn't take up infinite height
                        itemCount: resourcesController.confirmData.length,
                        itemBuilder: (context, index) {
                          return ResourceCard(
                            resource: resourcesController.confirmData[index],
                          );
                        },
                      );
                    }
                  },
                  onError: (error) => Center(child: Text('Error: $error')),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Requests',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            requestsController.obx(
              (state) {
                if (state == null) {
                  // Display a loading indicator when data is being fetched
                  return Center(child: CircularProgressIndicator());
                } else if (state.isEmpty) {
                  // Display a message when no data is available
                  return Center(child: Text('No data available'));
                } else {
                  // Display the list of volunteer requests
                  return ListView.builder(
                    shrinkWrap:
                        true, // Ensure the ListView doesn't take up infinite height
                    itemCount: requestsController.confirmData.length,
                    itemBuilder: (context, index) {
                      return RequestCard(
                        request: requestsController.confirmData[index],
                      );
                    },
                  );
                }
              },
              onError: (error) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}

// ...

// ...

class ResourceCard extends StatelessWidget {
  final ConfirmedResource resource;

  const ResourceCard({Key? key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              resource.resourceTitle,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 4),
            Text(
              resource.additionalDetails,
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Email: ${resource.email}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Owner ID: ${resource.ownerId}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Phone Number: ${resource.phoneNumber}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Resource ID: ${resource.resourceId}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "UID: ${resource.uid}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final ConfirmedRequest request;

  const RequestCard({Key? key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name: ${request.name}",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Number: ${request.number}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "UID: ${request.uid}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "ID: ${request.id}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Owner ID: ${request.ownerId}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Additional Details: ${request.additionalDetails}",
              style: GoogleFonts.inter(
                color: kBlack, // Custom color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
