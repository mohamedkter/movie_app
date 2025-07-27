import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/cache/cache_helper.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/movie_app.dart';
import 'core/firebase/firebase_service.dart';

Future main() async {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  // Initialize Firebases
  await FirebaseService.initialize();

  setupLocator();

  runApp(DevicePreview(
    enabled: true, // Set to true to enable Device Preview
    builder: (context) => const MovieApp(),
  ));
}
