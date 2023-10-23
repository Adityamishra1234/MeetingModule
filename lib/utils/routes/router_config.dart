import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:meeting_module2/di/get_it.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/add_more_notes.dart';
import 'package:meeting_module2/ui/screens/assign_to_view.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting2.dart';
import 'package:meeting_module2/ui/screens/dashboard_notes.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/ui/screens/loginUi.dart';
import 'package:meeting_module2/ui/screens/logintemp.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:meeting_module2/ui/screens/view_docs.dart';
import 'package:meeting_module2/ui/screens/view_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Routes {
  static const signin = '/';
  static const dashboard = DashBoard.routeNamed;
  static const createMeeting = CreateNewMeeting2.routeNamed;
  static const loginPage = LoginPage.routeNamed;
  static const addMoreNotesView = AddMoreNotesView.routeName;
  static const meetingDetails = MeetingDetails.routeNamed;
  static const viewNotes = ViewNotesDetails.routeNamed;
  static const assignViewMeetings = '/assignToView';
  static const viewDocs = 'viewDocs';
}

class GoRouterConfig {
  var router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.loginPage,
        builder: (context, state) {
          // Get.put(DashBoardController());
          return LoginPage();
        },
      ),

      // GoRoute(
      //   path: LoginPage.routeNamed,
      //   builder: (context, state) {
      //     // Get.put(DashBoardController());
      //     return LoginPage();
      //   },
      // ),
      // GoRoute(path: '/', builder: (context, state) => BaseScreen()),
      // GetPage(
      //           name: SignInView.route,
      //           page: () => SignInView(),
      //         ),
      //         GetPage(
      //           name: LoginPage.routeNamed,
      //           page: () => LoginPage(),
      //         ),
      //         GetPage(
      //             name: DashBoard.routeNamed,
      //             page: () => DashBoard(),
      //             binding: DashboardBinding()),
      //         GetPage(
      //           name: DashboardNotesView.routenamed,
      //           page: () => DashboardNotesView(),
      //         ),

      //         // GetPage(
      //         //   name: LoginPage.routeNamed,
      //         //   page: () => LoginPage(),
      //         // ),pi
      //         GetPage(
      //           name: ViewNotesDetails.routeNamed,
      //           page: () => ViewNotesDetails(),
      //         ),

      //         GetPage(
      //           name: ParticipantsDetails.routeNamed,
      //           page: () => ParticipantsDetails(),
      //         ),
      //         // GetPage(
      //         //   name: MeetingDetails.routeNamed,
      //         //   page: () => MeetingDetails(),
      //         //

      // GoRoute(
      //   path: Routes.createMeeting,
      //   builder: (context, state) {
      //     // Get.put(DashBoardController());
      //     return CreateNewMeeting2();
      //   },
      // ),
      // GoRoute(
      //   path: Routes.addMoreNotesView,
      //   builder: (context, state) {
      //     // Get.put(DashBoardController());
      //     return AddMoreNotesView();
      //   },
      // ),
      //         GetPage(
      //           name: CreateNewMeeting2.routeNamed,
      //           page: () => CreateNewMeeting2(),
      //         ),
      //         GetPage(
      //           name: AddRepresentative.routeNamed,
      //           page: () => AddRepresentative(),
      //         ),
      //         GetPage(
      //           name: RescheduleMeeting.routeNamed,
      //           page: () => RescheduleMeeting(),
      //         ),
      //         GetPage(
      //           name: DashBoard.routeNamed,
      //           page: () => DashBoard(),
      //         ),
      //         GetPage(
      //           name: AddMoreNotesView.routeName,
      //           page: () => AddMoreNotesView(),
      //
      //
      //      )

      GoRoute(
        path: '${Routes.assignViewMeetings}',
        builder: (context, state) => AssignToView(
          notesModel: state.extra as FindNotesModel,
        ),
      ),
      GoRoute(path: Routes.signin, builder: (context, state) => SignInView()),

      GoRoute(
          path: SignInView.route, builder: (context, state) => SignInView()),

      GoRoute(
          path: LoginPage.routeNamed, builder: (context, state) => LoginPage()),

      // GoRoute(
      //   path: SignInView.route,
      //   builder: (context, state) => SignInView(),
      // ),

      GoRoute(
          path: Routes.dashboard,
          builder: (context, state) {
            Get.put(DashBoardController());
            return DashBoard();
          },
          routes: [
            GoRoute(
                path: Routes.meetingDetails,
                builder: (context, state) => MeetingDetails(),
                routes: [
                  GoRoute(
                      path: '${Routes.viewNotes}/:id',
                      builder: (context, state) => ViewNotesDetails(
                            id: state.pathParameters['id']!,
                          ),
                      routes: []),
                  GoRoute(
                    path: '${Routes.addMoreNotesView}/:meetingId/:tab',
                    builder: (context, state) => AddMoreNotesView(
                      tab: state.pathParameters['tab']!,
                      meetingID: state.pathParameters['meetingId']!,
                    ),
                  ),
                  GoRoute(
                    path: '${Routes.viewDocs}',
                    builder: (context, state) => ViewDocs(),
                  ),
                ]),
            GoRoute(
              path: Routes.createMeeting,
              builder: (context, state) => CreateNewMeeting2(),
            ),
          ]),

      // GoRoute(
      //   path: AssignToView2.routeNamed,
      //   builder: (context, state) => AssignToView2(),
      // ),

      // GoRoute(
      //   path: CreateNewMeeting.routeNamed,
      //   builder: (context, state) => AssignToView2(),
      // ),

      // GoRoute(path: SignInView.route, builder: (context, state) => SignInView()),
    ],
    redirect: (context, state) async {
      if (state.fullPath == '/DashBoard') {
        // Get.find<DashBoardController>().onInit();
      }

      if (state.fullPath == '/') {
        SharedPreferences prefs = locator.get<SharedPreferences>();

        var id = 0;
        if (prefs.getInt('id') == null) {
          id = 0;
        } else {
          id = prefs.getInt('id')!;
        }

        if (await prefs.getString('token') == null) {
          print('dd');
        } else {
          // token = await prefs.getString('token')!;
        }
        if (id != 0) {
          Get.find<BaseController>().hideScreen();
          // BuildContext conte = Get.context!;

          return DashBoard.routeNamed;
          // context.go(DashBoard.routeNamed);
          // Get.offAllNamed(DashBoard.routeNamed);
        } else {
          await Get.find<BaseController>().hideScreen();
          return '/';
        }
      }

      // return id;
    },
  );
}
