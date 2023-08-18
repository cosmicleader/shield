// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/views/widgets/volunteers_request_tile.dart';

import '../../controllers/volunteer_page_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/custom_button.dart';

// class VolunteersPage extends StatefulWidget {
//   const VolunteersPage({super.key});

//   @override
//   State<VolunteersPage> createState() => _VolunteersPageState();
// }

// class _VolunteersPageState extends State<VolunteersPage> {
//   List<VolunteerRequest> volunteerRequests = [];
//   int currentPage = 1;
//   final ApiClient apiClient = ApiClient();

//   @override
//   void initState() {
//     super.initState();
//     loadMoreData();
//   }

//   Future<void> loadMoreData() async {
//     final newData =
//         await apiClient.fetchVolunteerRequests(page: currentPage + 1);
//     setState(() {
//       currentPage++;
//       volunteerRequests.addAll(newData);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var name = 'Guest';
//     return SafeArea(
//         child: Scaffold(
//       body: Column(children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.1,
//         ),
//         _buildAppBar(context, name),
//         _build20PXHeight(),
//         SizedBox(
//           width: MediaQuery.of(context).size.width - 40,
//           // width: 200, // Set a width for the container to control wrapping
//           child: const Text(
//             'WHAT DO YOU WANNA \nDO TODAY?',
//             style: TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//               color: Color(0x801B1B1B), // 0x80 for 50% transparency
//             ),
//             textAlign: TextAlign.left,
//           ),
//         ),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Image.asset("lib/assets/thumb/volunteers_page_thumb.png"),
//           ),
//         ),
//         Row(
//           children: [
//             _build20PXWidth(),
//             const CustomButton(
//               title: "BECOME A VOLUNTEER",
//             ),
//             _build20PXWidth(),
//             const CustomButton(
//               title: "REQUEST VOLUNTEERS",
//             ),
//             _build20PXWidth(),
//           ],
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width - 40,
//           child: const Divider(
//             color: Colors.black,
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: volunteerRequests.length,
//             itemBuilder: (context, index) {
//               final request = volunteerRequests[index];
//               return buildRequestTile(request);
//             },
//           ),
//         ),
//       ]),
//     ));
//   }
class VolunteersPage extends GetView<VolunteersController> {
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
                  onPressed: () {
                    final authController = Get.put(AuthController());
                    authController.isAuthenticated
                        ? (Get.snackbar(
                            "Become Volunteer", "This button has been pressed"))
                        : Get.toNamed(Routes.login);
                  },
                ),
                _build20PXWidth(),
                const CustomButton(
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
            Expanded(
              child: controller.obx(
                (state) => ListView.builder(
                  itemCount: state?.length,
                  itemBuilder: (context, index) {
                    final request = state?[index];
                    return buildRequestTile(request!);
                  },
                ),
                onError: (error) => Text('Error: $error'),
                onEmpty: const Text('No data available'),
                onLoading: const CircularProgressIndicator(),
              ),
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
    final volunteersController = Get.put(VolunteersController());
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
                child: Text(
                  'Hi ${volunteersController.name.value}...',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
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
