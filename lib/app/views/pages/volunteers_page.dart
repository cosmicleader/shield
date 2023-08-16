// ignore: file_names
import 'package:flutter/material.dart';

import '../../models/volunteer_request.dart';
import '../../services/api_client.dart';
import '../widgets/custom_button.dart';

class VolunteersPage extends StatefulWidget {
  const VolunteersPage({super.key});

  @override
  State<VolunteersPage> createState() => _VolunteersPageState();
}

class _VolunteersPageState extends State<VolunteersPage> {
  List<VolunteerRequest> volunteerRequests = [];
  int currentPage = 1;
  final ApiClient apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    loadMoreData();
  }

  Future<void> loadMoreData() async {
    final newData =
        await apiClient.fetchVolunteerRequests(page: currentPage + 1);
    setState(() {
      currentPage++;
      volunteerRequests.addAll(newData);
    });
  }

  @override
  Widget build(BuildContext context) {
    var name = 'Guest';
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 30,
              decoration: const BoxDecoration(color: Color(0xff1b1b1b)),
              child: Center(
                child: Text(
                  'Hi $name...',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
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
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          // width: 200, // Set a width for the container to control wrapping
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
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.amberAccent,
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width - 40,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            CustomButton(
              title: "BECOME A VOLUNTEER",
            ),
            SizedBox(
              width: 20,
            ),
            CustomButton(
              title: "BECOME A VOLUNTEER",
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: const Divider(
            color: Colors.black,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: volunteerRequests.length,
            itemBuilder: (context, index) {
              final request = volunteerRequests[index];
              return ListTile(
                title: Text(request.title),
                subtitle: Text(request.description),
                trailing: Text(request.requestType),
              );
            },
          ),
        ),
      ]),
    ));
  }
}
