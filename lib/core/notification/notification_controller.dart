// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class NotificationController extends GetxController {
//   static NotificationController get instance => Get.find();

//   Rx<String> firebaseToken = ''.obs;
//   Rx<String> nativeToken = ''.obs;

//   ReceivedAction? initialAction;

// //!  *********************************************
// //!     INITIALIZATION METHODS
// //!  *********************************************

//   static Future<void> initializeLocalNotifications({required bool debug}) async {
//     await AwesomeNotifications().initialize(
//         null, //'resource://drawable/res_app_icon',//
//         [
//           NotificationChannel(
//               channelKey: 'alerts',
//               channelName: 'Alerts',
//               channelDescription: 'Notification tests as alerts',
//               playSound: true,
//               importance: NotificationImportance.High,
//               defaultPrivacy: NotificationPrivacy.Private,
//               defaultColor: Colors.deepPurple,
//               ledColor: Colors.deepPurple),
//         ],debug: debug
//         );

//     instance.initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }

//   static Future<void> initializeRemoteNotifications({required bool debug}) async {
//     await Firebase.initializeApp();
//     await AwesomeNotificationsFcm().initialize(
//         onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
//         onFcmTokenHandle: NotificationController.myFcmTokenHandle,
//         onNativeTokenHandle: NotificationController.myNativeTokenHandle,
//         licenseKeys: [
//           // me.carda.awesomeNotificationsFcmExample
//           'B3J3yxQbzzyz0KmkQR6rDlWB5N68sTWTEMV7k9HcPBroUh4RZ/Og2Fv6Wc/lE',
//           '2YaKuVY4FUERlDaSN4WJ0lMiiVoYIRtrwJBX6/fpPCbGNkSGuhrx0Rekk',
//           '+yUTQU3C3WCVf2D534rNF3OnYKUjshNgQN8do0KAihTK7n83eUD60=',

//           // me.carda.awesome_notifications_fcm_example
//           'UzRlt+SJ7XyVgmD1WV+7dDMaRitmKCKOivKaVsNkfAQfQfechRveuKblFnCp4',
//           'zifTPgRUGdFmJDiw1R/rfEtTIlZCBgK3Wa8MzUV4dypZZc5wQIIVsiqi0Zhaq',
//           'YtTevjLl3/wKvK8fWaEmUxdOJfFihY8FnlrSA48FW94XWIcFY=',
//         ], debug: debug
//         );
//   }

// //!  *********************************************
// //!     REMOTE NOTIFICATION EVENTS
// //!  *********************************************

// //* Use this method to execute on background when a silent data arrives (even while terminated)
//   @pragma("vm:entry-point")
//   static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//     // Get.showSnackbar(
//     //   const GetSnackBar(
//     //     messageText: Text(
//     //       "Slient data received",
//     //       style: TextStyle(color: Colors.white, fontSize: 16),
//     //     ),
//     //     backgroundColor: Colors.black,
//     //   ),
//     // );
//     debugPrint('"SilentData": ${silentData.toString()}');
//     if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
//       debugPrint("bg");
//     } else {
//       debugPrint("FOREGROUND");
//     }

//     debugPrint("mySilentDatahandle received a FcmSilentData execution");
//     await executeLongTaskInBackground();
//   }

// //* Use this method to detect when a new fcm token is received
//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     // Get.showSnackbar(
//     //   const GetSnackBar(
//     //     messageText: Text(
//     //       "Fcm token received",
//     //       style: TextStyle(color: Colors.white, fontSize: 16),
//     //     ),
//     //     backgroundColor: Colors.black,
//     //   ),
//     // );
//     debugPrint('Firebase Token:"$token"');

//     instance.firebaseToken.value = token;
//   }

// //* Use this method to detect when a new native token is received
//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     // Get.showSnackbar(
//     //   const GetSnackBar(
//     //     messageText: Text(
//     //       "Native token received",
//     //       style: TextStyle(color: Colors.white, fontSize: 16),
//     //     ),
//     //     backgroundColor: Colors.black,
//     //   ),
//     // );
//     debugPrint('Native Token:"$token"');

//     instance.nativeToken.value = token;
//   }

// //! *********************************************
// //!     BACKGROUND TASKS TEST
// //!  *********************************************

//   static Future<void> executeLongTaskInBackground() async {
//     debugPrint("starting long task");
//     await Future.delayed(const Duration(seconds: 4));
//     final url = Uri.parse("http://google.com");
//     final re = await http.get(url);
//     debugPrint(re.body);
//     debugPrint("long task done");
//   }

// //!  *********************************************
// //!     REQUEST NOTIFICATION PERMISSIONS
// //!  *********************************************

//   static Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     BuildContext context = Get.context!;
//     await showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text('Get Notified!',
//                 style: Theme.of(context).textTheme.titleLarge),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Image.asset(
//                         'assets/animated-bell.gif',
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                     'Allow Awesome Notifications to send you beautiful notifications!'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Deny',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.red),
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     userAuthorized = true;
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Allow',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.deepPurple),
//                   )),
//             ],
//           );
//         });
//     return userAuthorized &&
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }

// // //!  *********************************************
// // //!    LOCAL NOTIFICATION CREATION METHODS
// // //!  *********************************************
//   static Future<void> createNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

//     if (!isAllowed) {
//       isAllowed = await displayNotificationRationale();
//     }

//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'channel_key',
//             title: 'Huston! The eagle has landed!',
//             body:
//                 "A small step for a man, but a giant leap to Flutter's community!",
//             bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {'notificationId': '1234567890'}),
//         actionButtons: [
//           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//           NotificationActionButton(
//               key: 'REPLY',
//               label: 'Reply Message',
//               requireInputText: true,
//               actionType: ActionType.SilentAction),
//           NotificationActionButton(
//               key: 'DISMISS',
//               label: 'Dismiss',
//               actionType: ActionType.DismissAction,
//               isDangerousOption: true)
//         ]);
//   }

//   static Future<void> resetBadge() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }

// //!  *********************************************
// //!    REMOTE TOKEN REQUESTS
// //!  *********************************************
//   static Future<String> requestFirebaseToken() async {
//     if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
//       try {
//         return await AwesomeNotificationsFcm().requestFirebaseAppToken();
//       } catch (exception) {
//         debugPrint('$exception');
//       }
//     } else {
//       debugPrint('Firebase is not available on this project');
//     }
//     return '';
//   }
// }
