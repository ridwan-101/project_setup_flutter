import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_setup/app.dart';
import 'package:project_setup/env.dart';
import 'package:project_setup/flavor.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> mainCommon(Flavor flavor) async {
  await runZonedGuarded<Future<void>>(
    () async {
      await initializeApp(flavor);
      runApp(const AppInitialization());
    },
    (error, stackTrace) {
      // Log errors appropriately based on environment
      if (kDebugMode) {
        developer.log(
          'Unhandled error: $error',
          name: 'Project Setup',
          error: error,
          stackTrace: stackTrace,
        );
      } else {
        // In production, you might want to send to crash reporting service
        // like Firebase Crashlytics or Sentry
        debugPrint('Unhandled error: $error');
      }
    },
  );
}

Future<void> initializeApp(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set app flavor
  F.appFlavor = flavor;

  // Validate environment configuration
  if (!Env.isConfigured) {
    throw FlutterError(
      'Environment not properly configured. Please check your .env files.',
    );
  }

  developer.log(
    '🔧 Running Environment: ${F.appFlavor}',
    name: 'Project Setup Init',
  );

  // Clear secure storage on first run
  await _clearStorageOnFirstRun();

  // Set device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Additional initialization can go here
  // e.g., Firebase, crash reporting, analytics, etc.
}

Future<void> _clearStorageOnFirstRun() async {
  try {
    const String firstRunKey = 'first_run';
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(firstRunKey) ?? true) {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
      await prefs.setBool(firstRunKey, false);

      if (kDebugMode) {
        developer.log(
          'Cleared secure storage on first run',
          name: 'Project Setup Init',
        );
      }
    }
  } catch (e) {
    developer.log('Error clearing storage: $e', name: 'Project Setup Init');
  }
}
