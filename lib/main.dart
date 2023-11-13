import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/features/app/presentation/app_view.dart';

import 'core/injection/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();

  runApp(StopWatchAppView());
}
