import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/controllers/auth_controller.dart';
import 'package:shield/app/views/themes/colours.dart';

import '../../utils/calculate_time_ago.dart';

class ChatPageController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  TextEditingController messageController = TextEditingController();

  Future<void> sendMessage(String text) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final message = {
        'text': text,
        'senderId': currentUser.uid,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('messages').add(message);
      messageController.clear();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  void _loadMessages() {
    _firestore.collection('messages').orderBy('timestamp').snapshots().listen(
      (snapshot) {
        messages.assignAll(snapshot.docs.map((doc) => doc.data()).toList());
      },
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatPageController controller = Get.put(ChatPageController());
    final authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack, // Background color for the app bar
        elevation: 0, // Remove the shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded), // Back button icon
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: kWhite,
              radius: 20, // Adjust the radius as needed
              // backgroundImage:
              //     Icon(Icons.escalator_warning_sharp), // Use your avatar image
              child: Icon(
                Icons.escalator_warning_sharp,
                color: kBlack,
              ),
            ),
            const SizedBox(
                width: 10), // Adjust spacing between avatar and title
            Text(
              'GLOBAL CHAT',
              style: GoogleFonts.inter(
                color: kWhite, // Text color for the title
                fontWeight: FontWeight.bold,
                fontSize: 16, // Adjust the font size as needed
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isCurrentUser =
                      message['senderId'] == authController.getUID;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!isCurrentUser)
                          CircleAvatar(
                            // Add user's profile picture here
                            radius: 0,
                            backgroundColor: kRed,

                            // backgroundImage: AssetImage('assets/avatar.png'),
                          ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 4.0,
                            bottom: 4.0,
                            left: isCurrentUser ? 32.0 : 0.0,
                            right: isCurrentUser ? 0.0 : 32.0,
                          ),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Colors.green // Your sent message color
                                : Colors
                                    .grey[200], // Other user's message color
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: isCurrentUser
                                  ? Radius.circular(8)
                                  : Radius.zero,
                              bottomRight: isCurrentUser
                                  ? Radius.zero
                                  : Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['text'],
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '${calculateTimeAgo(message['timestamp'].toDate())}',
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.black.withOpacity(0.7),
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = controller.messageController.text;
                    if (message.isNotEmpty) {
                      controller.sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
