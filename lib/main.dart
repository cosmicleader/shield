import 'package:flutter/material.dart';
// import 'package:shield/lib/firebase_options.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
