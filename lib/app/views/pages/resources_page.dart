import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/confirm_resources_controller.dart';
import 'package:shield/app/views/themes/colours.dart';

import '../../controllers/resources_controller.dart';
import '../../models/resources_model.dart';
import '../bottomsheet/create_resource.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resourceController = Get.put(ResourcesController());
    resourceController.fetchResources();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kBlack)),
                          child: const Text('Post Resource'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return CreateResourceBottomSheet(); // Replace with the name of your bottom sheet widget
                              },
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Sort by:'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kBlack)),
                            onPressed: () {
                              resourceController.sortResources();
                            },
                            child: const Text('AVAILABILITY'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: resourceController.filterByValue.value,
                              onChanged: (String? newValue) {
                                resourceController
                                    .filterResources(newValue ?? 'All');
                              },
                              items: <String>[
                                'All',
                                'Water',
                                'Cloths',
                                // Add more types as needed
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: resourceController.resources.length,
                    itemBuilder: (context, index) {
                      final resource = resourceController.resources[index];

                      // Check if the resource type matches the selected filter type
                      if (resourceController.filterByValue.value == 'All' ||
                          resource.type ==
                              resourceController.filterByValue.value) {
                        return buildCustomResourceCard(resource, context);
                      }

                      // If the filter doesn't match, return an empty container
                      return Container();
                    },
                  )),
                ],
              )),
        ),
      ),
    );
  }
}

Card buildCustomResourceCard(Resource resource, BuildContext context) {
  return Card(
    elevation: 4.0,
    margin: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        // Handle resource selection or request here
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource.title, // Title
              style: GoogleFonts.inter(
                fontSize: 24.0, // Font size 24
                fontWeight: FontWeight.bold, // Bold font weight
              ),
            ),
            // SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Location', // String on the left side
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, // Bold font weight
                          fontSize: 16.0, // Font size 16
                        ),
                      ),
                      TextSpan(
                        text:
                            ': ${resource.location}', // Content on the right side
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.normal, // Regular font weight
                          fontSize: 16.0, // Font size 16
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Type', // String on the left side
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, // Bold font weight
                          fontSize: 16.0, // Font size 16
                        ),
                      ),
                      TextSpan(
                        text: ': ${resource.type}', // Content on the right side
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.normal, // Regular font weight
                          fontSize: 16.0, // Font size 16
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    // Handle resource request here
                    showDialog(
                      context: context,
                      builder: (context) => ResourceRequestDialog(),
                    );
                  },
                  child: const Text('Request'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              resource.isAvailable ? 'Available' : 'Unavailable',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: resource.isAvailable ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ResourceRequestDialog extends StatelessWidget {
  final TextEditingController _additionalDetailsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirmation',
        style: GoogleFonts.inter(
            color: kBlack, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you want to send this request?',
            style: GoogleFonts.inter(
              color: kBlack,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _additionalDetailsController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Additional Details (optional)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(
              color: kBlack,
              fontSize: 12,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kBlack),
          ),
          onPressed: () {
            // Perform the request and use _additionalDetailsController.text
            // to access the additional details.
            String additionalDetails = _additionalDetailsController.text;
            _additionalDetailsController.clear();
            final confirmResourcesController =
                Get.put(ConfirmResourcesController());
            // Add your logic here
            confirmResourcesController.sendRequest(additionalDetails);

            Get.back(); // Close the dialog
          },
          child: Text(
            'Confirm',
            style: GoogleFonts.inter(
                color: kWhite, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
