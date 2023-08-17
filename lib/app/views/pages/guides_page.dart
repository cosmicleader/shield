import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/guides_controller.dart';

class GuidesPage extends GetView<GuidesController> {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guides Page')),
      body: const Center(
        child: Text('Content of Guides Page'),
      ),
    );
  }
}
