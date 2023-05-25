import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/bindings/dashboardBindings.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/add_more_notes.dart';
import 'package:meeting_module2/ui/screens/add_representative.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting2.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/ui/screens/login_page.dart';
import 'package:meeting_module2/ui/screens/loginview.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';
import 'package:meeting_module2/ui/screens/nfvf.dart';
import 'package:meeting_module2/ui/screens/participants_details.dart';
import 'package:meeting_module2/ui/screens/reschedule_meeting.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:meeting_module2/ui/screens/view_notes.dart';
import 'firebase_options.dart';
import 'message.dart';
import 'package:http/http.dart' as http;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  // String? initialMessage;
  // bool _resolved = false;
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  // FirebaseMessaging.instance.getInitialMessage().then((value) {
  //   _resolved = true;
  //   initialMessage = value?.data.toString();
  // });

  // FirebaseMessaging.onMessage.listen(showFlutterNotification);

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('A new onMessageOpenedApp event was published!');
  //   Navigator.pushNamed(
  //     Get.context!,
  //     '/message',
  //     arguments: MessageArguments(message, true),
  //   );
  // });
  // onActionSelected;
  // // createtoken();
  runApp(MyApp());
}

Future<void> onActionSelected(String value) async {
  switch (value) {
    case 'subscribe':
      {
        print(
          'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
        );
        await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
        print(
          'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
        );
      }
      break;
    case 'unsubscribe':
      {
        print(
          'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
        );
        await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
        print(
          'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
        );
      }
      break;
    case 'get_apns_token':
      {
        if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          print('FlutterFire Messaging Example: Getting APNs token...');
          String? token = await FirebaseMessaging.instance.getAPNSToken();
          print('FlutterFire Messaging Example: Got APNs token: $token');
        } else {
          print(
            'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
          );
        }
      }
      break;
    default:
      break;
  }
}

// createtoken() async {
//   var token = await FirebaseMessaging.instance.getToken(
//       vapidKey:
//           'BNKkaUWxyP_yC_lki1kYazgca0TNhuzt2drsOrL6WrgGbqnMnr8ZMLzg_rSPDm6HKphABS0KzjPfSqCXHXEd06Y');

//   if (token != null) {
//     sendPushMessage(token);
//   }
// }

// // FCM send Notification using Token
// sendPushMessage(String token) async {
//   if (token == null) {
//     print('Unable to send FCM message, no token exists.');
//     return;
//   }

//   try {
//     await http.post(
//       Uri.parse('https://api.rnfirebase.io/messaging/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: constructFCMPayload(token),
//     );
//     print('FCM request for device sent!');
//   } catch (e) {
//     print(e);
//   }
// }

int _messageCount = 0;
String constructFCMPayload(String? token) {
  print(token);
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

// Future<void> onActionSelected(String value) async {
//   switch (value) {
//     case 'subscribe':
//       {
//         print(
//           'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
//         );
//         await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
//         print(
//           'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
//         );
//       }
//       break;
//     case 'unsubscribe':
//       {
//         print(
//           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
//         );
//         await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
//         print(
//           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
//         );
//       }
//       break;
//     case 'get_apns_token':
//       {
//         if (defaultTargetPlatform == TargetPlatform.iOS ||
//             defaultTargetPlatform == TargetPlatform.macOS) {
//           print('FlutterFire Messaging Example: Getting APNs token...');
//           String? token = await FirebaseMessaging.instance.getAPNSToken();
//           print('FlutterFire Messaging Example: Got APNs token: $token');
//         } else {
//           print(
//             'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
//           );
//         }
//       }
//       break;
//     default:
//       break;
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SignInView.route,
        getPages: [
          GetPage(
            name: SignInView.route,
            page: () => SignInView(),
          ),
          GetPage(
            name: LoginPage.routeNamed,
            page: () => LoginPage(),
          ),
          GetPage(
            name: DashBoard.routeNamed,
            page: () => DashBoard(),
          ),
          // GetPage(
          //   name: LoginPage.routeNamed,
          //   page: () => LoginPage(),
          // ),
          GetPage(
            name: ViewNotesDetails.routeNamed,
            page: () => ViewNotesDetails(),
          ),
          GetPage(
            name: ParticipantsDetails.routeNamed,
            page: () => ParticipantsDetails(),
          ),
          // GetPage(
          //   name: MeetingDetails.routeNamed,
          //   page: () => MeetingDetails(),
          // ),
          GetPage(
            name: CreateNewMeeting2.routeNamed,
            page: () => CreateNewMeeting2(),
          ),
          GetPage(
            name: AddRepresentative.routeNamed,
            page: () => AddRepresentative(),
          ),
          GetPage(
            name: RescheduleMeeting.routeNamed,
            page: () => RescheduleMeeting(),
          ),
          GetPage(
            name: DashBoard.routeNamed,
            page: () => const DashBoard(),
            // binding: DashboardBinding()
          ),
          GetPage(
            name: AddMoreNotesView.routeName,
            page: () => AddMoreNotesView(),
            // binding: DashboardBinding()
          )
        ]);
  }
}




// class MessagingExampleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Messaging Example App',
//       theme: ThemeData.dark(),
//       routes: {
//         '/': (context) => Application(),
//         '/message': (context) => MessageView(),
//       },
//     );
//   }
// }



// String constructFCMPayload(String? token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }

// class Application extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Application();
// }

// class _Application extends State<Application> {
//   String? _token;
//   String? initialMessage;
//   bool _resolved = false;

//   @override
//   void initState() {
//     super.initState();

//     FirebaseMessaging.instance.getInitialMessage().then(
//           (value) => setState(
//             () {
//               _resolved = true;
//               initialMessage = value?.data.toString();
//             },
//           ),
//         );

//     FirebaseMessaging.onMessage.listen(showFlutterNotification);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       Navigator.pushNamed(
//         context,
//         '/message',
//         arguments: MessageArguments(message, true),
//       );
//     });
//   }

// // FCM send Notification using Token
//   Future<void> sendPushMessage() async {
//     if (_token == null) {
//       print('Unable to send FCM message, no token exists.');
//       return;
//     }

//     try {
//       await http.post(
//         Uri.parse('https://api.rnfirebase.io/messaging/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: constructFCMPayload(_token),
//       );
//       print('FCM request for device sent!');
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> onActionSelected(String value) async {
//     switch (value) {
//       case 'subscribe':
//         {
//           print(
//             'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
//           );
//           await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
//           print(
//             'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
//           );
//         }
//         break;
//       case 'unsubscribe':
//         {
//           print(
//             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
//           );
//           await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
//           print(
//             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
//           );
//         }
//         break;
//       case 'get_apns_token':
//         {
//           if (defaultTargetPlatform == TargetPlatform.iOS ||
//               defaultTargetPlatform == TargetPlatform.macOS) {
//             print('FlutterFire Messaging Example: Getting APNs token...');
//             String? token = await FirebaseMessaging.instance.getAPNSToken();
//             print('FlutterFire Messaging Example: Got APNs token: $token');
//           } else {
//             print(
//               'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
//             );
//           }
//         }
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cloud Messaging'),
//         actions: <Widget>[
//           PopupMenuButton(
//             onSelected: onActionSelected,
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem(
//                   value: 'subscribe',
//                   child: Text('Subscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'unsubscribe',
//                   child: Text('Unsubscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'get_apns_token',
//                   child: Text('Get APNs token (Apple only)'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: Builder(
//         builder: (context) => FloatingActionButton(
//           onPressed: sendPushMessage,
//           backgroundColor: Colors.white,
//           child: const Icon(Icons.send),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             MetaCard('Permissions', Permissions()),
//             MetaCard(
//               'Initial Message',
//               Column(
//                 children: [
//                   Text(_resolved ? 'Resolved' : 'Resolving'),
//                   Text(initialMessage ?? 'None'),
//                 ],
//               ),
//             ),
//             MetaCard(
//               'FCM Token',
//               TokenMonitor((token) {
//                 _token = token;
//                 return token == null
//                     ? const CircularProgressIndicator()
//                     : SelectableText(
//                         token,
//                         style: const TextStyle(fontSize: 12),
//                       );
//               }),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseMessaging.instance
//                     .getInitialMessage()
//                     .then((RemoteMessage? message) {
//                   if (message != null) {
//                     Navigator.pushNamed(
//                       context,
//                       '/message',
//                       arguments: MessageArguments(message, true),
//                     );
//                   }
//                 });
//               },
//               child: const Text('getInitialMessage()'),
//             ),
//             MetaCard('Message Stream', MessageList()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MetaCard extends StatelessWidget {
//   final String _title;
//   final Widget _children;

//   // ignore: public_member_api_docs
//   MetaCard(this._title, this._children);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Text(_title, style: const TextStyle(fontSize: 18)),
//               ),
//               _children,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
