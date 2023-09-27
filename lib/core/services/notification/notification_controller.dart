import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends ChangeNotifier {
  final box = GetStorage();
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  String _firebaseToken = '';
  String get firebaseToken => _firebaseToken;

  String _nativeToken = '';
  String get nativeToken => _nativeToken;

  ReceivedAction? initialAction;

//!  *********************************************
//!     INITIALIZATION METHODS
//!  *********************************************

  static Future<void> initializeLocalNotifications(
      {required bool debug}) async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'gout-app',
            channelName: 'Gout App Notifications',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.deepPurple,
            ledColor: Colors.deepPurple,
            criticalAlerts: true,
          ),
        ],
        debug: debug);

    _instance.initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> initializeRemoteNotifications(
      {required bool debug}) async {
    await Firebase.initializeApp();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
        onFcmTokenHandle: NotificationController.myFcmTokenHandle,
        onNativeTokenHandle: NotificationController.myNativeTokenHandle,
        licenseKeys: [
          // me.carda.awesomeNotificationsFcmExample
          'B3J3yxQbzzyz0KmkQR6rDlWB5N68sTWTEMV7k9HcPBroUh4RZ/Og2Fv6Wc/lE',
          '2YaKuVY4FUERlDaSN4WJ0lMiiVoYIRtrwJBX6/fpPCbGNkSGuhrx0Rekk',
          '+yUTQU3C3WCVf2D534rNF3OnYKUjshNgQN8do0KAihTK7n83eUD60=',

          // me.carda.awesome_notifications_fcm_example
          'UzRlt+SJ7XyVgmD1WV+7dDMaRitmKCKOivKaVsNkfAQfQfechRveuKblFnCp4',
          'zifTPgRUGdFmJDiw1R/rfEtTIlZCBgK3Wa8MzUV4dypZZc5wQIIVsiqi0Zhaq',
          'YtTevjLl3/wKvK8fWaEmUxdOJfFihY8FnlrSA48FW94XWIcFY=',
        ],
        debug: debug);
  }

//!  *********************************************
//!     REMOTE NOTIFICATION EVENTS
//!  *********************************************

//* Use this method to execute on background when a silent data arrives (even while terminated)
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      debugPrint("bg");
    } else {
      debugPrint("FOREGROUND");
    }

    debugPrint("mySilentDatahandle received a FcmSilentData execution");
  }

//* Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('Firebase Token:"$token"');
    _instance.box.write("fcmToken", token);
    _instance._firebaseToken = token;
  }

//* Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');

    _instance._nativeToken = token;
  }

//!  *********************************************
//!     REQUEST NOTIFICATION PERMISSIONS
//!  *********************************************

  static Future<void> allowPermission() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> notAllowPermission() async {
    await AwesomeNotifications().cancelAll();
    await AwesomeNotifications().cancelAllSchedules();
    await AwesomeNotifications().cancelNotificationsByChannelKey("gout-app");
    await AwesomeNotifications().dismissAllNotifications();
    await AwesomeNotifications().dismissNotificationsByChannelKey("gout-app");
  }

// //!  *********************************************
// //!    LOCAL NOTIFICATION EVENTS
// //!  *********************************************
  static Future<void> getInitialNotificationAction() async {
    ReceivedAction? receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: true);
    if (receivedAction == null) return;
    debugPrint('Notification action launched app: $receivedAction');
  }

// //!  *********************************************
// //!    LOCAL NOTIFICATION CREATION METHODS
// //!  *********************************************
  static Future<void> resetBadge() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

//!  *********************************************
//!    REMOTE TOKEN REQUESTS
//!  *********************************************
  static Future<String> requestFirebaseToken() async {
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        return await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (exception) {
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return '';
  }
}
