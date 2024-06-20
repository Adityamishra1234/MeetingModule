import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/presentation/meeting_notes_task/view/meeting_notes_task_view_bloc.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting2.dart';
import 'package:meeting_module2/utils/theme.dart';

import '../ui/controller/dashboardController.dart';
import '../ui/screens/dashboard_notes.dart';
import '../utils/routes/router_config.dart';

class CustomNavBar extends StatefulWidget {
  static const routeNamed = '/mainScreen';
  CustomNavBar(
      {super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int _currentIndex= widget.currentIndex;
  int visit = 0;
  double height = 25;
  Color colorSelect =const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const  Color(0XFF1752FE);
  bool dialog = false;

  // var controller = Get.put(BaseController(), permanent: true);
  late List<Widget> _pages;

 final List<TabItem> items = [
    TabItem(
      icon: Icons.home,
      title: 'Dashboard',

    ),
    TabItem(
      icon: Icons.note_sharp,
      title: 'My Notes',
    ),
   TabItem(
     icon: Icons.task,
     title: 'My Tasks',
   ),
   // TabItem(
   //   icon: Icons.logout_rounded,
   //   title: 'LogOut',
   // ),

  ];
  var controller = Get.put(DashBoardController(), permanent: true);
  @override
  void initState() {
    _pages = [
      PageOne(),
      PageTwo(),
      PageThree(),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Exit"),
                content: const Text("Are you sure you want to Exit?"),
                actions: [
                  TextButton(
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                          color: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              );
            });
        return false;
      },
      child: Scaffold(
        appBar: null,
        body: _pages[visit],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            gradient: ThemeConstants.backgroundGradient,
          ),
          child: BottomBarInspiredInside(
            gradient: ThemeConstants.backgroundGradient,
            items: items,
            backgroundColor: Color(0xff3088C6),
            color: Colors.white,
            colorSelected: Colors.white,
            indexSelected: visit,
            onTap: (int index) => setState(() {
              visit = index;
            }),
            animated: true,
            chipStyle:const ChipStyle(isHexagon: true, convexBridge: true),
            itemStyle: ItemStyle.hexagon,
          ),

          // BottomBarInspiredOutside(
          //   items: items,
          //   isAnimated: true,
          //   backgroundColor: Colors.transparent,
          //   color: Colors.white,
          //   colorSelected: Colors.white,
          //   indexSelected: visit,
          //   onTap: (int index) => setState(() {
          //     visit = index;
          //     // if(index == 3){
          //     //   showDialog(
          //     //     barrierDismissible: dialog,
          //     //       context: context,
          //     //       builder: (context) {
          //     //         return AlertDialog(
          //     //           title: const Text("Logout"),
          //     //           content: const Text("Are you sure you want to Logout?"),
          //     //           actions: [
          //     //             TextButton(
          //     //               onPressed: () => SystemChannels.platform
          //     //                   .invokeMethod('SystemNavigator.pop'),
          //     //               child: const Text(
          //     //                 "Yes",
          //     //                 style: TextStyle(
          //     //                   color: Colors.grey,
          //     //                 ),
          //     //               ),
          //     //             ),
          //     //             TextButton(
          //     //               onPressed: () {
          //     //                 Get.toNamed(DashBoard.routeNamed);
          //     //                 setState(() {
          //     //                   dialog  = !dialog;
          //     //                   visit = 0;
          //     //                 });
          //     //               },
          //     //               child: const Text(
          //     //                 "No",
          //     //                 style: TextStyle(
          //     //                     color: Colors.blueAccent,
          //     //                     fontWeight: FontWeight.bold
          //     //                 ),
          //     //               ),
          //     //             ),
          //     //           ],
          //     //         );
          //     //       });
          //     // }
          //
          //     // if(visit==0){
          //     //   Navigator.pushNamed(context, '${Routes.dashboard}/${Routes.viewDashboardNotes}');
          //     // }
          //     // else if(visit==1){
          //     //
          //     // }
          //     // else if(visit == 2){
          //     //   context.push(
          //     //       '${Routes.dashboard}/${Routes.usesNotesTask}/${controller.user.value.id}');
          //     // }
          //   }),
          //   top: -55,
          //   animated: true,
          //   itemStyle: ItemStyle.hexagon,
          //   chipStyle:const ChipStyle(drawHexagon: true),
          // ),


        ),
      ),
    );
  }
}


class PageOne extends StatefulWidget {
  final String? name;
  PageOne({Key? key, this.name}) : super(key: key);
  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {


  @override
  Widget build(BuildContext context) {
    // Get.deleteAll();
    return const DashBoard();
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get.deleteAll();
    return DashboardNotesView();
  }
}

class PageThree extends StatelessWidget {
  var controller = Get.put(DashBoardController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    // Get.deleteAll();
    return MeetingNotesTaskViewBloc(id : '${controller.user.value.id}' );
  }
}


// context.push(
// '${Routes.dashboard}/${Routes.usesNotesTask}/${controller.user.value.id}');