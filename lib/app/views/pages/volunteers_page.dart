// ignore_for_file: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/controllers/volunteer_page_controller.dart';
import 'package:shield/app/models/volunteer_request.dart';
import 'package:shield/app/services/firebase_services.dart';
import 'package:shield/app/views/pages/request_volunteer_page.dart';

import 'package:shield/app/views/widgets/volunteers_request_tile.dart';

import '../../routes/app_pages.dart';
import '../widgets/custom_button.dart';

class VolunteersPage extends StatelessWidget {
  const VolunteersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            _buildAppBar(context),
            _build20PXHeight(),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: const Text(
                'WHAT DO YOU WANNA \nDO TODAY?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0x801B1B1B),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child:
                    Image.asset("lib/assets/thumb/volunteers_page_thumb.png"),
              ),
            ),
            Row(
              children: [
                _build20PXWidth(),
                CustomButton(
                  title: "BECOME A VOLUNTEER",
                  onPressed: () async {
                    final authController = Get.put(AuthController());
                    authController.isAuthenticated
                        ? await getRequest()
                        : Get.toNamed(Routes.login);
                  },
                ),
                _build20PXWidth(),
                CustomButton(
                  onPressed: () {
                    final authController = Get.put(AuthController());
                    authController.isAuthenticated
                        ? kRequestVolunteerDialog()
                        : Get.toNamed(Routes.login);
                    kRequestVolunteerDialog();
                  },
                  title: "REQUEST VOLUNTEERS",
                ),
                _build20PXWidth(),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: const Divider(
                color: Colors.black,
              ),
            ),
            StreamBuilder(
              stream: firestore.collection('requests').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                var requests = snapshot.data!.docs;
                List<VolunteerRequest> requestWidgets = requests.map((doc) {
                  var requestData = doc.data();

                  final timestamp = requestData['postedTime'];
                  log(timestamp.toString());

                  return VolunteerRequest(
                      id: requestData['title'],
                      title: requestData['title'],
                      description: requestData['description'],
                      postedTime: DateTime.now(),
                      requestType: requestData['requestType']);
                }).toList();
                return GetBuilder<VolunteersController>(
                  init: VolunteersController(),
                  initState: (_) {},
                  builder: (controller) {
                    return Expanded(
                      child: controller.obx(
                        (state) => ListView.builder(
                          itemCount: requestWidgets.length,
                          itemBuilder: (context, index) {
                            return buildRequestTile(requestWidgets[index]);
                          },
                        ),
                        onError: (error) => const Text('Error: '),
                        onEmpty: const Text('No data available'),
                        onLoading: const CircularProgressIndicator(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ... _buildAppBar and other methods

  SizedBox _build20PXWidth() {
    return const SizedBox(
      width: 20,
    );
  }

  SizedBox _build20PXHeight() {
    return const SizedBox(
      height: 20,
    );
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xff1b1b1b),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20), // Adjust left padding as needed
                child: GetBuilder<AuthController>(
                  init: AuthController(),
                  initState: (_) {},
                  builder: (controller) {
                    return Text(
                      controller.isAuthenticated
                          ? 'Hi ${controller.usernameOrEmail ?? 'Anonymous'}'
                          : 'Hi  Guest',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: const Color(0xff1b1b1b),
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
