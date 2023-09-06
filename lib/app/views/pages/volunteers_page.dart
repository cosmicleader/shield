import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/controllers/volunteer_page_controller.dart';
import 'package:shield/app/services/firebase_service.dart';
import 'package:shield/app/views/pages/request_volunteer_page.dart';
import 'package:shield/app/views/widgets/request_tile.dart';
import '../../routes/app_pages.dart';
import '../widgets/custom_button.dart';

class VolunteersPage extends StatelessWidget {
  const VolunteersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Top section with padding
            TopSection(),

            AppBarSection(),

            // Header section containing a title and an image
            HeaderSection(),

            // Image section
            // ImageSection(),

            // Buttons for becoming a volunteer and requesting volunteers
            ButtonSection(),

            // Divider section
            DividerSection(),

            // Volunteer list section with data fetched from the controller
            VolunteerListSection(),
          ],
        ),
      ),
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Container for user information and greeting
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
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

          // Container for notifications icon
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xff1b1b1b),
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () {
                // Get.to(() => NotificationPage());
                Get.toNamed('/notification');
              },
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title text
        SizedBox(
          width: MediaQuery.of(context).size.width - 16,
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

        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset("assets/thumb/volunteers_page_thumb.png"),
          ),
        ),
      ],
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = Get.put(FirebaseService());
    return Row(
      children: [
        const Spacer(),

        // Button for becoming a volunteer
        CustomButton(
          title: "BECOME A VOLUNTEER",
          onPressed: () async {
            final authController = Get.put(AuthController());
            authController.isAuthenticated
                ? await firebaseService.getRequest()
                : Get.toNamed(Routes.login);
          },
        ),

        const Spacer(),

        // Button for requesting volunteers
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

        const Spacer(),
      ],
    );
  }
}

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 16,
      child: const Divider(
        color: Colors.black,
      ),
    );
  }
}

class VolunteerListSection extends StatelessWidget {
  const VolunteerListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VolunteersController());

    return Expanded(
      child: controller.obx(
        (state) {
          if (state == null) {
            // Display a loading indicator when data is being fetched
            return const Center(child: CircularProgressIndicator());
          } else if (state.isEmpty) {
            // Display a message when no data is available
            return const Center(child: Text('No data available'));
          } else {
            // Display the list of volunteer requests
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return RequestTile(request: state[index]);
                // return buildRequestTile(state[index]);
              },
            );
          }
        },
        onError: (error) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
