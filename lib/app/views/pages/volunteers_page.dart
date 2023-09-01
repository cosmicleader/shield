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
                  color: Color(0x801B1B1B), // 0x80 for 50% transparency
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
                    // Get.to(RequestVolunteerPage());
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
                  // Convert the timestamp to a datetime object
                  // final datetime =
                  //     DateTime.fromMillisecondsSinceEpoch(timestamp);
                  // log(datetime.toString());
                  // log(datetime.toString());
                  // final formattedDatetime =
                  //     DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);

                  return VolunteerRequest(
                      id: requestData['title'],
                      title: requestData['title'],
                      description: requestData['description'],
                      postedTime: DateTime.now(),
                      // postedTime: DateTime..strptime(timestamp, "%Y-%m-%dT%H:%M:%SZ")(
                      //     requestData['description']),
                      requestType: requestData['requestType']);
                  // return ListTile(
                  //   title: Text(
                  //     requestData['title'],
                  //     style: GoogleFonts.inter(fontSize: 16, color: kBlack),
                  //   ),
                  //   subtitle: Text(requestData['description'],
                  //       style: GoogleFonts.inter(fontSize: 16, color: kBlack)),
                  // );
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
                            // final request = state?[index];
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

                // return Expanded(
                //   child: ListView(
                //     shrinkWrap: true,
                //     children: requestWidgets,
                //   ),
                // );
              },
            ),
            // GetBuilder<VolunteersController>(
            //   init: VolunteersController(),
            //   initState: (_) {},
            //   builder: (controller) {
            //     return Expanded(
            //       child: controller.obx(
            //         (state) => ListView.builder(
            //           itemCount: state?.length,
            //           itemBuilder: (context, index) {
            //             final request = state?[index];
            //             return buildRequestTile(request!);
            //           },
            //         ),
            //         onError: (error) => const Text('Error: '),
            //         onEmpty: const Text('No data available'),
            //         onLoading: const CircularProgressIndicator(),
            //       ),
            //     );
            //   },
            // ),
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
