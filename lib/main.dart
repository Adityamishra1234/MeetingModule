// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:flutter_splash_screen/flutter_splash_screen.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:meeting_module2/bindings/dashboardBindings.dart';
// import 'package:meeting_module2/fcm/notification_service.dart';
// import 'package:meeting_module2/utils/routes/router_config.dart';
// import 'package:meeting_module2/di/get_it.dart';
// import 'package:meeting_module2/models/dashboardNotesModel.dart';
// import 'package:meeting_module2/ui/controller/base_controller.dart';
// import 'package:meeting_module2/ui/screens/add_more_notes.dart';
// import 'package:meeting_module2/ui/screens/add_representative.dart';
// import 'package:meeting_module2/ui/screens/create_new_meeting2.dart';
// import 'package:meeting_module2/ui/screens/dashboard_notes.dart';
// import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
// import 'package:meeting_module2/ui/screens/login_page.dart';
// import 'package:meeting_module2/ui/screens/participants_details.dart';
// import 'package:meeting_module2/ui/screens/reschedule_meeting.dart';
// import 'package:meeting_module2/ui/screens/signin_view.dart';
// import 'package:meeting_module2/ui/screens/view_notes.dart';
// import 'package:meeting_module2/utils/theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'fcm/firebase_options.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart';
// // import 'package:flutter_splash_screen/flutter_splash_screen.dart';
//
// // @pragma('vm:entry-point')
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //   await setupFlutterNotifications();
// //   showFlutterNotification(message);
//
// //   print('Handling a background message ${message.messageId}');
// // }
//
// // late AndroidNotificationChannel channel;
//
// // bool isFlutterLocalNotificationsInitialized = false;
//
// // Future<void> setupFlutterNotifications() async {
// //   if (isFlutterLocalNotificationsInitialized) {
// //     return;
// //   }
// //   channel = const AndroidNotificationChannel(
// //     'high_importance_channel', // id
// //     'High Importance Notifications', // title
// //     description:
// //         'This channel is used for important notifications.', // description
// //     importance: Importance.high,
// //   );
//
// //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// //   await flutterLocalNotificationsPlugin
// //       .resolvePlatformSpecificImplementation<
// //           AndroidFlutterLocalNotificationsPlugin>()
// //       ?.createNotificationChannel(channel);
//
// //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// //     alert: true,
// //     badge: true,
// //     sound: true,
// //   );
// //   isFlutterLocalNotificationsInitialized = true;
// // }
//
// // void showFlutterNotification(RemoteMessage message) {
// //   RemoteNotification? notification = message.notification;
// //   AndroidNotification? android = message.notification?.android;
// //   if (notification != null && android != null && !kIsWeb) {
// //     flutterLocalNotificationsPlugin.show(
// //       notification.hashCode,
// //       notification.title,
// //       notification.body,
// //       NotificationDetails(
// //         android: AndroidNotificationDetails(
// //           channel.id,
// //           channel.name,
// //           channelDescription: channel.description,
// //           // TODO add a proper drawable resource to andrwoid, for now using
// //           //      one that already exists in example app.
// //           icon: 'launch_background',
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // int id = 0;
//
// // Future<void> _showNotification() async {
// //   const AndroidNotificationDetails androidNotificationDetails =
// //       AndroidNotificationDetails('your channel id', 'your channel name',
// //           channelDescription: 'your channel description',
// //           importance: Importance.max,
// //           priority: Priority.high,
// //           ticker: 'ticker');
// //   const NotificationDetails notificationDetails =
// //       NotificationDetails(android: androidNotificationDetails);
// //   await flutterLocalNotificationsPlugin.show(
// //       id++, 'plain title', 'plain body', notificationDetails,
// //       payload: 'item x');
// // }
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
//
// class DownloadClass {
//   static void callback(String id, int status, int progress) {
//     print('Download Status: $status');
//     print('Download Prgress: $progress');
//   }
// }
//
// Future<void> main() async {
//   // String? initialMessage;
//   // bool _resolved = false;
//   // WidgetsFlutterBinding.ensureInitialized();
//
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   // if (!kIsWeb) {
//   //   await setupFlutterNotifications();
//   // }
//   // FirebaseMessaging.instance.getInitialMessage().then((value) {
//   //   _resolved = true;
//   //   initialMessage = value?.data.toString();
//   // });
//
//   // FirebaseMessaging.onMessage.listen(showFlutterNotification);
//
//   // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //   print('A new onMessageOpenedApp event was published!');
//
//   //     Get.context!,
//   //     '/message',
//   //     arguments: MessageArguments(message, true),
//   //   );
//   // });
//   // await onActionSelected;
//   // await createtoken();
//
//   // SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.portraitUp,
//   //   DeviceOrientation.portraitDown,
//   // ]).then((value) => runApp(MyApp()));
//
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(systemStatusBarContrastEnforced: true));
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   await setupDI();
//   // FlutterSplashScreen.
//   // await _showNotification();
//   runApp(MyApp());
// }
//
// // Future<void> onActionSelected(String value) async {
// //   switch (value) {
// //     case 'subscribe':
// //       {
// //         print(
// //           'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
// //         );
// //         await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
// //         print(
// //           'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
// //         );
// //       }
// //       break;
//
// //     case 'unsubscribe':
// //       {
// //         print(
// //           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
// //         );
// //         await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
// //         print(
// //           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
// //         );
// //       }
// //       break;
// //     case 'get_apns_token':
// //       {
// //         if (defaultTargetPlatform == TargetPlatform.iOS ||
// //             defaultTargetPlatform == TargetPlatform.macOS) {
// //           print('FlutterFire Messaging Example: Getting APNs token...');
// //           String? token = await FirebaseMessaging.instance.getAPNSToken();
// //           print('FlutterFire Messaging Example: Got APNs token: $token');
// //         } else {
// //           print(
// //             'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
// //           );
// //         }
// //       }
// //       break;
// //     default:
// //       break;
// //   }
// // }
//
// // createtoken() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   // var id = await prefs.getInt('id')!;
//
// //   var token = await FirebaseMessaging.instance.getToken(
// //       vapidKey:
// //           'BNKkaUWxyP_yC_lki1kYazgca0TNhuzt2drsOrL6WrgGbqnMnr8ZMLzg_rSPDm6HKphABS0KzjPfSqCXHXEd06Y');
//
// //   await prefs.setString('token', '$token');
// // }
//
// // // FCM send Notification using Token
// // sendPushMessage(String token) async {
// //   if (token == null) {
// //     print('Unable to send FCM message, no token exists.');
// //     return;
// //   }
//
// //   try {
// //     await http.post(
// //       Uri.parse('https://api.rnfirebase.io/messaging/send'),
// //       headers: <String, String>{
// //         'Content-Type': 'application/json; charset=UTF-8',
// //       },
// //       body: constructFCMPayload(token),
// //     );
// //     print('FCM request for device sent!');
// //   } catch (e) {
// //     print(e);
// //   }
// // }
//
// // int _messageCount = 0;
// // String constructFCMPayload(String? token) {
// //   print(token);
// //   _messageCount++;
// //   return jsonEncode({
// //     'token': token,
// //     'data': {
// //       'via': 'FlutterFire Cloud Messaging!!!',
// //       'count': _messageCount.toString(),
// //     },
// //     'notification': {
// //       'title': 'Hello FlutterFire!',
// //       'body': 'This notification (#$_messageCount) was created via FCM!',
// //     },
// //   });
// // }
//
// // Future<void> onActionSelected(String value) async {
// //   switch (value) {
// //     case 'subscribe':
// //       {
// //         print(
// //           'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
// //         );
// //         await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
// //         print(
// //           'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
// //         );
// //       }
// //       break;
// //     case 'unsubscribe':
// //       {
// //         print(
// //           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
// //         );
// //         await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
// //         print(
// //           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
// //         );
// //       }
// //       break;
// //     case 'get_apns_token':
// //       {
// //         if (defaultTargetPlatform == TargetPlatform.iOS ||
// //             defaultTargetPlatform == TargetPlatform.macOS) {
// //           print('FlutterFire Messaging Example: Getting APNs token...');
// //           String? token = await FirebaseMessaging.instance.getAPNSToken();
// //           print('FlutterFire Messaging Example: Got APNs token: $token');
// //         } else {
// //           print(
// //             'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
// //           );
// //         }
// //       }
// //       break;
// //     default:
// //       break;
// //   }
// // }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   NotificationServices notificationServices = NotificationServices();
//   @override
//   void initState() {
//     // hideScreen();
//     notificationServices.requestNotificationPermission();
//     notificationServices.forgroundMessage();
//     notificationServices.firebaseInit(context);
//     notificationServices.setupInteractMessage(context);
//     notificationServices.isTokenRefresh();
//
//     notificationServices.getDeviceToken().then((value) {
//       if (kDebugMode) {
//         print('device token');
//         print(value);
//       }
//     });
//
//     // data();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   // Future<void> hideScreen() async {
//   //   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   //   // String phonenumber = sharedPreferences.getString("phonenumber").toString();
//   //   // if (getNUllChecker(phonenumber) == false) {
//   //   //   var controller = Get.put(BaseController(), permanent: true);
//   //   // }
//
//   //   if (Platform.isIOS) {
//   //     Future.delayed(const Duration(milliseconds: 8000), () {
//   //       FlutterSplashScreen.hide();
//   //     });
//   //   } else {
//   //     Future.delayed(const Duration(milliseconds: 5100), () {
//   //       FlutterSplashScreen.hide();
//   //     });
//   //   }
//   // }
//
//   var controllerBase = Get.put(BaseController(), permanent: true);
//   // data() async {
//   //   var data = await Future.delayed(Duration(seconds: 2));
//   // }
//
//   // final routerDelegate = BeamerDelegate(
//   //   locationBuilder: BeamerLocationBuilder(
//   //     beamLocations: [BooksLocation()],
//   //   ),
//   //   notFoundRedirectNamed: '/books',
//   // );
//   GoRouter router = GoRouterConfig().router;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routeInformationParser: router.routeInformationParser,
//       routeInformationProvider: router.routeInformationProvider,
//       routerDelegate: router.routerDelegate,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           useMaterial3: false,
//           primaryColor: ThemeConstants.bluecolor,
//           primarySwatch: Colors.blue),
//       // routerConfig: GoRouterConfig().router,
//       //         routerDelegate: routerDelegate,
// // routeInformationParser: BeamerParser(),
//       // smartManagement: SmartManagement.keepFactory,
//       // initialRoute: SignInView.route,
//       // getPages: [
//       //   GetPage(
//       //     name: SignInView.route,
//       //     page: () => SignInView(),
//       //   ),
//       // name: DashBoard.routeNamed,
//       // page: () => DashBoard(),
//       // ),
//       //   GetPage(
//       //     name: LoginPage.routeNamed,
//       //     page: () => LoginPage(),
//       //   ),
//       //   GetPage(
//       //       name: DashBoard.routeNamed,
//       //       page: () => DashBoard(),
//       //       binding: DashboardBinding()),
//       //   GetPage(
//       //     name: DashboardNotesView.routenamed,
//       //     page: () => DashboardNotesView(),
//       //   ),
//
//       //   // GetPage(
//       //   //   name: LoginPage.routeNamed,
//       //   //   page: () => LoginPage(),
//       //   // ),pi
//       //   GetPage(
//       //     name: ViewNotesDetails.routeNamed,
//       //     page: () => ViewNotesDetails(),
//       //   ),
//       //   GetPage(
//       //     name: ParticipantsDetails.routeNamed,
//       //     page: () => ParticipantsDetails(),
//       //   ),
//       //   // GetPage(
//       //   //   name: MeetingDetails.routeNamed,
//       //   //   page: () => MeetingDetails(),
//       //   //
//       //   GetPage(
//       //     name: CreateNewMeeting2.routeNamed,
//       //     page: () => CreateNewMeeting2(),
//       //   ),
//       //   GetPage(
//       //     name: AddRepresentative.routeNamed,
//       //     page: () => AddRepresentative(),
//       //   ),
//       //   GetPage(
//       //     name: RescheduleMeeting.routeNamed,
//       //     page: () => RescheduleMeeting(),
//       //   ),
//       //   GetPage(
//       //     name: DashBoard.routeNamed,
//       //     page: () => DashBoard(),
//       //   ),
//       //   GetPage(
//       //     name: AddMoreNotesView.routeName,
//       //     page: () => AddMoreNotesView(),
//       //   )
//       // ]
//     );
//   }
// }
//
// // class MessagingExampleApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Messaging Example App',
// //       theme: ThemeData.dark(),
// //       routes: {
// //         '/': (context) => Application(),
// //         '/message': (context) => MessageView(),
// //       },
// //     );
// //   }
// // }
//
// // String constructFCMPayload(String? token) {
// //   _messageCount++;
// //   return jsonEncode({
// //     'token': token,
// //     'data': {
// //       'via': 'FlutterFire Cloud Messaging!!!',
// //       'count': _messageCount.toString(),
// //     },
// //     'notification': {
// //       'title': 'Hello FlutterFire!',
// //       'body': 'This notification (#$_messageCount) was created via FCM!',
// //     },
// //   });
// // }
//
// // class Application extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _Application();
// // }
//
// // class _Application extends State<Application> {
// //   String? _token;
// //   String? initialMessage;
// //   bool _resolved = false;
//
// //   @override
// //   void initState() {
// //     super.initState();
//
// //     FirebaseMessaging.instance.getInitialMessage().then(
// //           (value) => setState(
// //             () {
// //               _resolved = true;
// //               initialMessage = value?.data.toString();
// //             },
// //           ),
// //         );
//
// //     FirebaseMessaging.onMessage.listen(showFlutterNotification);
//
// //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //       print('A new onMessageOpenedApp event was published!');
// //       Navigator.pushNamed(
// //         context,
// //         '/message',
// //         arguments: MessageArguments(message, true),
// //       );
// //     });
// //   }
//
// // // FCM send Notification using Token
// //   Future<void> sendPushMessage() async {
// //     if (_token == null) {
// //       print('Unable to send FCM message, no token exists.');
// //       return;
// //     }
//
// //     try {
// //       await http.post(
// //         Uri.parse('https://api.rnfirebase.io/messaging/send'),
// //         headers: <String, String>{
// //           'Content-Type': 'application/json; charset=UTF-8',
// //         },
// //         body: constructFCMPayload(_token),
// //       );
// //       print('FCM request for device sent!');
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
//
// //   Future<void> onActionSelected(String value) async {
// //     switch (value) {
// //       case 'subscribe':
// //         {
// //           print(
// //             'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
// //           );
// //           await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
// //           print(
// //             'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
// //           );
// //         }
// //         break;
// //       case 'unsubscribe':
// //         {
// //           print(
// //             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
// //           );
// //           await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
// //           print(
// //             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
// //           );
// //         }
// //         break;
// //       case 'get_apns_token':
// //         {
// //           if (defaultTargetPlatform == TargetPlatform.iOS ||
// //               defaultTargetPlatform == TargetPlatform.macOS) {
// //             print('FlutterFire Messaging Example: Getting APNs token...');
// //             String? token = await FirebaseMessaging.instance.getAPNSToken();
// //             print('FlutterFire Messaging Example: Got APNs token: $token');
// //           } else {
// //             print(
// //               'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
// //             );
// //           }
// //         }
// //         break;
// //       default:
// //         break;
// //     }
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Cloud Messaging'),
// //         actions: <Widget>[
// //           PopupMenuButton(
// //             onSelected: onActionSelected,
// //             itemBuilder: (BuildContext context) {
// //               return [
// //                 const PopupMenuItem(
// //                   value: 'subscribe',
// //                   child: Text('Subscribe to topic'),
// //                 ),
// //                 const PopupMenuItem(
// //                   value: 'unsubscribe',
// //                   child: Text('Unsubscribe to topic'),
// //                 ),
// //                 const PopupMenuItem(
// //                   value: 'get_apns_token',
// //                   child: Text('Get APNs token (Apple only)'),
// //                 ),
// //               ];
// //             },
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: Builder(
// //         builder: (context) => FloatingActionButton(
// //           onPressed: sendPushMessage,
// //           backgroundColor: Colors.white,
// //           child: const Icon(Icons.send),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             MetaCard('Permissions', Permissions()),
// //             MetaCard(
// //               'Initial Message',
// //               Column(
// //                 children: [
// //                   Text(_resolved ? 'Resolved' : 'Resolving'),
// //                   Text(initialMessage ?? 'None'),
// //                 ],
// //               ),
// //             ),
// //             MetaCard(
// //               'FCM Token',
// //               TokenMonitor((token) {
// //                 _token = token;
// //                 return token == null
// //                     ? const CircularProgressIndicator()
// //                     : SelectableText(
// //                         token,
// //                         style: const TextStyle(fontSize: 12),
// //                       );
// //               }),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 FirebaseMessaging.instance
// //                     .getInitialMessage()
// //                     .then((RemoteMessage? message) {
// //                   if (message != null) {
// //                     Navigator.pushNamed(
// //                       context,
// //                       '/message',
// //                       arguments: MessageArguments(message, true),
// //                     );
// //                   }
// //                 });
// //               },
// //               child: const Text('getInitialMessage()'),
// //             ),
// //             MetaCard('Message Stream', MessageList()),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // class MetaCard extends StatelessWidget {
// //   final String _title;
// //   final Widget _children;
//
// //   // ignore: public_member_api_docs
// //   MetaCard(this._title, this._children);
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
// //       child: Card(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             children: [
// //               Container(
// //                 margin: const EdgeInsets.only(bottom: 16),
// //                 child: Text(_title, style: const TextStyle(fontSize: 18)),
// //               ),
// //               _children,
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }



import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/fcm/notification_service.dart';
import 'package:meeting_module2/services/Network/api_services.dart';
import 'package:meeting_module2/services/Network/interceptors.dart';
import 'package:meeting_module2/utils/routes/router_config.dart';
import 'package:meeting_module2/di/get_it.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bloc_Repo_Field_Activity/Repo/get_field_activity_repo.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_splash_screen/flutter_splash_screen.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await setupFlutterNotifications();
//   showFlutterNotification(message);

//   print('Handling a background message ${message.messageId}');
// }

// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           // TODO add a proper drawable resource to andrwoid, for now using
//           //      one that already exists in example app.
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }

// int id = 0;

// Future<void> _showNotification() async {
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails('your channel id', 'your channel name',
//           channelDescription: 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker');
//   const NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await flutterLocalNotificationsPlugin.show(
//       id++, 'plain title', 'plain body', notificationDetails,
//       payload: 'item x');
// }

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class DownloadClass {
  static void callback(String id, int status, int progress) {
    print('Download Status: $status');
    print('Download Progress: $progress');
  }
}

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

  //     Get.context!,
  //     '/message',
  //     arguments: MessageArguments(message, true),
  //   );
  // });
  // await onActionSelected;
  // await createtoken();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((value) => runApp(MyApp()));

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemStatusBarContrastEnforced: true));
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupDI();final prefs = await SharedPreferences.getInstance();

  Dio dio = Dio();
  dio.interceptors.add(AppInterceptors());
  final ApiService apiService = ApiService(dio);

  // FlutterSplashScreen.
  // await _showNotification();
  runApp(MyApp(prefs, apiService));
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

// createtoken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   // var id = await prefs.getInt('id')!;

//   var token = await FirebaseMessaging.instance.getToken(
//       vapidKey:
//           'BNKkaUWxyP_yC_lki1kYazgca0TNhuzt2drsOrL6WrgGbqnMnr8ZMLzg_rSPDm6HKphABS0KzjPfSqCXHXEd06Y');

//   await prefs.setString('token', '$token');
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

// int _messageCount = 0;
// String constructFCMPayload(String? token) {
//   print(token);
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

class MyApp extends StatefulWidget {
  SharedPreferences prefs;
  ApiService apiService;
  MyApp(
      this.prefs,
      this.apiService, {
        super.key,
      });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // hideScreen();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });

    // data();
    // TODO: implement initState
    super.initState();
  }

  // Future<void> hideScreen() async {
  //   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // String phonenumber = sharedPreferences.getString("phonenumber").toString();
  //   // if (getNUllChecker(phonenumber) == false) {
  //   //   var controller = Get.put(BaseController(), permanent: true);
  //   // }

  //   if (Platform.isIOS) {
  //     Future.delayed(const Duration(milliseconds: 8000), () {
  //       FlutterSplashScreen.hide();
  //     });
  //   } else {
  //     Future.delayed(const Duration(milliseconds: 5100), () {
  //       FlutterSplashScreen.hide();
  //     });
  //   }
  // }

  var controllerBase = Get.put(BaseController(), permanent: true);
  // data() async {
  //   var data = await Future.delayed(Duration(seconds: 2));
  // }

  // final routerDelegate = BeamerDelegate(
  //   locationBuilder: BeamerLocationBuilder(
  //     beamLocations: [BooksLocation()],
  //   ),
  //   notFoundRedirectNamed: '/books',
  // );
  GoRouter router = GoRouterConfig().router;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: MultiProvider(
        providers: [
          Provider<FieldActivityRepo>.value(
              value: FieldActivityRepo(widget.apiService, widget.prefs)),
        ],
        child: MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: false,
              primaryColor: ThemeConstants.bluecolor,
              primarySwatch: Colors.blue),
          // routerConfig: GoRouterConfig().router,
          //         routerDelegate: routerDelegate,
          // routeInformationParser: BeamerParser(),
          // smartManagement: SmartManagement.keepFactory,
          // initialRoute: SignInView.route,
          // getPages: [
          //   GetPage(
          //     name: SignInView.route,
          //     page: () => SignInView(),
          //   ),
          // name: DashBoard.routeNamed,
          // page: () => DashBoard(),
          // ),
          //   GetPage(
          //     name: LoginPage.routeNamed,
          //     page: () => LoginPage(),
          //   ),
          //   GetPage(
          //       name: DashBoard.routeNamed,
          //       page: () => DashBoard(),
          //       binding: DashboardBinding()),
          //   GetPage(
          //     name: DashboardNotesView.routenamed,
          //     page: () => DashboardNotesView(),
          //   ),

          //   // GetPage(
          //   //   name: LoginPage.routeNamed,
          //   //   page: () => LoginPage(),
          //   // ),pi
          //   GetPage(
          //     name: ViewNotesDetails.routeNamed,
          //     page: () => ViewNotesDetails(),
          //   ),
          //   GetPage(
          //     name: ParticipantsDetails.routeNamed,
          //     page: () => ParticipantsDetails(),
          //   ),
          //   // GetPage(
          //   //   name: MeetingDetails.routeNamed,
          //   //   page: () => MeetingDetails(),
          //   //
          //   GetPage(
          //     name: CreateNewMeeting2.routeNamed,
          //     page: () => CreateNewMeeting2(),
          //   ),
          //   GetPage(
          //     name: AddRepresentative.routeNamed,
          //     page: () => AddRepresentative(),
          //   ),
          //   GetPage(
          //     name: RescheduleMeeting.routeNamed,
          //     page: () => RescheduleMeeting(),
          //   ),
          //   GetPage(
          //     name: DashBoard.routeNamed,
          //     page: () => DashBoard(),
          //   ),
          //   GetPage(
          //     name: AddMoreNotesView.routeName,
          //     page: () => AddMoreNotesView(),
          //   )
          // ]
        ),
      ),
    );
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
