import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/services/notification/notification_controller.dart';
import 'package:gout_app/firebase_options.dart';

@immutable
class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await NotificationController.initializeLocalNotifications(debug: true);
    await NotificationController.initializeRemoteNotifications(debug: true);
    await GetStorage.init();
  }
}
