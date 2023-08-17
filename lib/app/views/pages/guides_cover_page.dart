import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/guides_cover_controller.dart';

class GuidesCoverPage extends GetView<GuidesCoverController> {
  const GuidesCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guides Cover Page')),
      body: const Center(
        child: Text('Content of Guides Cover Page'),
      ),
    );
  }
}
