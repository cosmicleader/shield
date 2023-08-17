import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/resources_controller.dart';

class ResourcesPage extends GetView<ResourcesController> {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources Page')),
      body: const Center(
        child: Text('Content of Resources Page'),
      ),
    );
  }
}
