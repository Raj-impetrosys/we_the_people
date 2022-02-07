import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wethepeople/globals/app_constants.dart';
import 'package:wethepeople/views/tab_view.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
  debugPrint("Handling a background message: ${message.data}");
  debugPrint("Handling a background message: ${message.category}");
  debugPrint("Handling a background message: ${message.notification!.title}");
  debugPrint("Handling a background message: ${message.notification!.body}");
}

firebase(context) async {
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  debugPrint('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');
    // setState(() {
    //   data = message;
    // });

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification!.title}');
      debugPrint(message.notification!.title);
      debugPrint(message.notification!.body);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('onMessageOpenedApp: ' + message.notification!.title.toString());
    Constants.index = 0;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BottomTabBar()));
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

// class Notification1 extends StatelessWidget {
//   final RemoteNotification notification;
//   const Notification1({Key key, @required this.notification}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(notification.title),
//         ),
//         body: ListView(
//           children: [Text(notification.body)],
//         ),
//       ),
//     );
//   }
// }
