import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customExpansionTile.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_dialogue.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/popups/custom_error_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardController extends GetxController with StateMixin {
  ApiServices api = ApiServices();

  RxString selectedFilter = 'All Meetings'.obs;

  List<AllMeetings> allMeetingslist = [];

  int indexOfTab = 0;

  // RxList<AllMeetings> listToShowBackup = <AllMeetings>[].obs;

  // List<AllMeetings> doneMeetings = [];

  // List<AllMeetings> upcomingMeetings = [];

  List<AllMeetings> listToShow = <AllMeetings>[];

  RxList<AllUserModel> allUserList = <AllUserModel>[].obs;

  RxList<AllUserModel> listBro = <AllUserModel>[].obs;

  RxList<FindNotesModel> notesList = <FindNotesModel>[].obs;

  // RxList<AllMeetings> internalMeetingList = <AllMeetings>[].obs;

  // RxList<AllMeetings> externalMeetingList = <AllMeetings>[].obs;

  RxBool loading = false.obs;

  RxBool loading1 = false.obs;
  var helo = 0.obs;

  @override
  void onInit() async {
    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5
    super.onInit();
    // print('fff');
    // await token();
    // helo.value = 2;
    await getMeetingData();

    // getNotes('1', null);
  }

  // token() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var id = await prefs.getInt('id');
  //   var token = await prefs.getString('token');
  //   var data = await ApiServices().updateFCMToken(id, token);
  //   print(token);
  //   if (token != null) {
  //     sendPushMessage(token);
  //   }
  // }

  frfr(val) {
    print('$val dcdcd');
    selectedFilter.value = val;
    print(selectedFilter.value);
    update();
  }

  Rx<UserModel> user = UserModel().obs;

  getMeetingData() async {
    change(null, status: RxStatus.loading());
    // RxStatus.loading();
    // print('dddd');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    print(id);

    ///todo

    var res = await api.getAllMeetings(id!);

    if (res != false) {
      // var data = await json.decode(res);

      allMeetingslist =
          await List<AllMeetings>.from(res.map((x) => AllMeetings.fromJson(x)));

      RxList<AllMeetings> userID = <AllMeetings>[].obs;
      showUpcomingList();
    }

    var email = await prefs.getString('email');
    var password = await prefs.getString('password');

    var login = await api.login(email: email!, password: password!);

    // var data = json.decode(login);

    user.value = UserModel.fromJson(login);

    change(null, status: RxStatus.success());

//     allMeetingslist.forEach((e) {

// userID.add(item);
//       e.siecParticipants!.where((element) => element.id == userID);
//       e.meetingCoordinator!.where((element) => element.id == userID);
//     });

    // var res2 = await api.getDropdown(Endpoints.allUser);

    // var data2 = await json.decode(res2);

    // allUserList.value = await List<AllUserModel>.from(
    //     data2.map((x) => AllUserModel.fromJson(x)));

    // listBro.value =
    //     List<AllUserModel>.from(allUserList.map((element) => element)).toList();
    // loading1.value = true;

    // list = await data;

    // allMeetingslist.where((element) {
    //   print(element);
    //   if (element.meetingEnded == true) {
    //     print(element);
    //     doneMeetings.add(element);
    //   }

    //   return true;
    // });
    // print(doneMeetings.length);

    // for (var i = 0; i < allMeetingslist.length; i++) {
    //   if (allMeetingslist[i].meetingEnded == true) {
    //     doneMeetings.add(allMeetingslist[i]);
    //     print(doneMeetings);
    //   } else {
    //     upcomingMeetings.add(allMeetingslist[i]);
    //   }
    // }
    // loading.value = false;

    // listToShow = upcomingMeetings;

    // update();
  }

  Rx<AllMeetings> selectedMeetingdata = AllMeetings().obs;

  List<Map<String, List<Widget>>> dataBaazi = [];
  List<FindNotesModel> meetingNotesList = [];
  List<FindNotesModel> observationNotesList = [];
  List<FindNotesModel> proposeChangesNotesList = [];
  List<FindNotesModel> processNotesList = [];
  List<FindNotesModel> traningNotesList = [];
  List<FindNotesModel> requirementsNotesList = [];
  List<FindNotesModel> universityNotesList = [];
  List<FindNotesModel> offlineMarketingNotesList = [];

  List<Widget> documentlist = [];

  getNotes(String id, int? index) async {
    if (index != null) {
      selectedMeetingdata.value = listToShow[index];
    }
    var res = await api.findNotes(id);

    print('res');

    print(res.toString());

    // List<FindNotesModel> data = List<FindNotesModel>.from(
    //     json.decode(res).map((x) => FindNotesModel.fromJson(x)));

    var data =
        List<FindNotesModel>.from(res.map((x) => FindNotesModel.fromJson(x)));
    notesList.value = await data;

/////
    ///

    List notesType = [];
    List notesTypeString = [];

    for (var i = 0; i < notesList.length; i++) {
      notesType.add(notesList[i].noteType);
    }

    notesType = notesType.toSet().toList();

    for (var i = 0; i < notesType.length; i++) {
      var res = getNoteTypefromId(notesType[i]);

      // var data1 = res.toString().split(' ')[0];
      // var data2 = res.toString().split(' ')[1] == null
      //     ? ''
      //     : res.toString().split(' ')[1];
      // print(data1 + data2);

      // print(temp);

      notesTypeString.add(res);
    }

    List<Map<String, List<FindNotesModel>>> list = [];
    for (var i = 0; i < notesType.length; i++) {
      list.add({notesTypeString[i]: []});
    }

    for (var i = 0; i < notesList.length; i++) {
      for (var j = 0; j < notesTypeString.length; j++) {
        if (list[j].entries.first.key ==
            getNoteTypefromId(notesList[i].noteType!)) {
          list[j].entries.first.value.add(notesList[i]);
        }
      }

      // if(  notesList[i].note
      //Type )
      // list.add({[]: })
    }

    List<Widget> beta = [];
    for (var i = 0; i < list.length; i++) {
      beta.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: CustomExpansionPlanList(
          titel: list[i].keys.first,
          dataList: list[i].values.first,
        ),
      ));
      // documentlist.addAll(list[i].entries.first.value);
    }
    documentlist = [];
    documentlist = beta;
    print(documentlist.length);

    update();

    // dataBaazi = list;

    ///todo
    // await notesList.value.where((e) {
    //   if (e.noteType == 1) {
    //     meetingNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 2) {
    //     observationNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 3) {
    //     proposeChangesNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 4) {
    //     processNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 5) {
    //     traningNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 6) {
    //     requirementsNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 7) {
    //     universityNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 8) {
    //     offlineMarketingNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // proposeChangesNotesList =
    //     await notesList.value.where((e) => e.noteType == 3).toList();
    // processNotesList =
    //     await notesList.value.where((e) => e.noteType == 4).toList();

    // traningNotesList =
    //     await notesList.value.where((e) => e.noteType == 5).toList();
    // requirementsNotesList =
    //     await notesList.value.where((e) => e.noteType == 6).toList();

    // universityNotesList =
    //     await notesList.value.where((e) => e.noteType == 7).toList();

    // offlineMarketingNotesList =
    //     await notesList.value.where((e) => e.noteType == 8).toList();
  }

  RxBool upcomingbuttonEnable = true.obs;

  // internalMeeting() {
  //   internalMeetingList.value = allMeetingslist
  //       .where((ele) => ele.meetingType == 'Internal Meeting')
  //       .toList();
  // }

  // enternalMeeting() {
  //   externalMeetingList.value = allMeetingslist
  //       .where((ele) => ele.meetingType == 'External Meeting')
  //       .toList();
  // }

  changeInFilter() async {
    if (indexOfTab == 0) {
      if (selectedFilter.value == "All Meetings") {
        // print('dcdcd');
        listToShow = await allMeetingslist
            .where(
              (ele) => ele.meetingEnded == false,
            )
            .toList();
      } else if (selectedFilter.value == "University Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 'university' && p0.meetingEnded == false)
            .toList();
      } else if (selectedFilter.value == "Vendor Meeting") {
        listToShow = await allMeetingslist
            .where(
                (p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == false)
            .toList();
      } else if (selectedFilter.value == "Internal Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingEnded == false &&
                p0.meetingType == 'Internal Meeting')
            .toList();
      } else if (selectedFilter.value == "Bank Meeting") {
        listToShow = await allMeetingslist
            .where((p0) => p0.meetingWith == 'bank' && p0.meetingEnded == false)
            .toList();
      }
    } else if (indexOfTab == 1) {
      if (selectedFilter.value == "All Meetings") {
        // print('dcdcd');
        listToShow = await allMeetingslist
            .where(
              (ele) => ele.meetingEnded == true,
            )
            .toList();
      } else if (selectedFilter.value == "University Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 'university' && p0.meetingEnded == true)
            .toList();
      } else if (selectedFilter.value == "Vendor Meeting") {
        listToShow = await allMeetingslist
            .where(
                (p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == true)
            .toList();
      } else if (selectedFilter.value == "Internal Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingEnded == true && p0.meetingType == 'Internal Meeting')
            .toList();
      } else if (selectedFilter.value == "Bank Meeting") {
        listToShow = await allMeetingslist
            .where((p0) => p0.meetingWith == 'bank' && p0.meetingEnded == true)
            .toList();
      }
    }

    update();
  }

  showUpcomingList() async {
    // print('ddd');

    changeInFilter();
  }

  // upcomingMeetings;
  //   await Future.delayed(Duration(seconds: 2));

  //   // change(listToShow, status: RxStatus.success());
  //   loading.value = false;
  //   // update();
  // }

  showDoneList() async {
    changeInFilter();
    loading.value = false;
    print('ddddd');

    // listToShow = doneMeetings;

    // if (selectedFilter.value == "All Meetings") {
    //   listToShow = await allMeetingslist
    //       .where(
    //         (ele) => ele.meetingEnded == false,
    //       )
    //       .toList();
    // } else if (selectedFilter.value == "University Meeting") {
    //   listToShow = await internalMeetingList
    //       .where(
    //           (p0) => p0.meetingWith == 'university' && p0.meetingEnded == true)
    //       .toList();
    // } else if (selectedFilter.value == "Vendor Meeting") {
    //   listToShow = await internalMeetingList
    //       .where((p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == true)
    //       .toList();
    // }

    // // upcomingMeetings;
    // await Future.delayed(Duration(seconds: 2));

    // // change(listToShow, status: RxStatus.success());
    // loading.value = false;

    // showSpecificMeeting(value) async {
    //   listToShowBackup = listToShow;

    //   if (selectedFilter.value == 'Vendor Meeting') {
    //     listToShow = await listToShowBackup
    //         .where(
    //           (ele) => ele.meetingEnded == true && ele.meetingWith == 'vendor',
    //         )
    //         .toList();

    //     update();
    //   }
    // }

    // await Future.delayed(Duration(seconds: 2));

    // // change(listToShow, status: RxStatus.success());
    // loading.value = false;
    // // change(loading, status: RxStatus.success());
    // update();
  }

  bool hitResheduleAPI = false;

  resheduleMeeting(data) async {
//     {
//     "meetingId": 3,
//     "reasonOfReshedule": "test",
//     "rescheduleDate": "12/10/2004",
//     "rescheduleTime": "20:20",
//     "rescheduleDuration": "20 hours 20 minutes",
//     "meetingType": "zoom",
//     "modeOfMeeting": "0" ,
//     "meetingLink": "test",
//     "updatedBY": 44

// }

    var res = await api.resheduleMeeting(data);
    Get.back();
    //todo
    Get.defaultDialog();
    getMeetingData();
  }

  singleMeetingDetails(BuildContext context) {
    bool menu = false;
    List<Widget> data = [];
    for (var i = 0; i < listToShow.length; i++) {
      data.add(InkWell(
        onTap: () {
          Get.find<BaseController>().selectedMeeting(listToShow[i]);
          // getNotes('${listToShow[i].id}', i);
          Get.to(MeetingDetails());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10, bottom: 2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 255, 225, 150),
                    Color.fromARGB(255, 255, 225, 150),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  stops: [0.00, 0.05, 0.05],
                ),
                border: Border.all(color: const Color(0xff1940b3)),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            // width: 300,
                            child: CustomAutoSizeTextMontserrat(
                              text: "${listToShow[i].meetingAgenda}",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              listToShow[i].meetingStarted! &&
                                      !listToShow[i].meetingEnded!
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Radio(
                                              activeColor: Colors.green,
                                              value: true,
                                              groupValue: true,
                                              onChanged: (val) {}),
                                        ),
                                        CustomAutoSizeTextMontserrat(
                                          fontSize: 12,
                                          text: '(Started)',
                                          textColor: ThemeConstants.GreenColor,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              listToShow[i].meetingStarted! &&
                                      listToShow[i].meetingEnded!
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Radio(
                                              activeColor: Colors.red,
                                              value: true,
                                              groupValue: true,
                                              onChanged: (val) {}),
                                        ),
                                        CustomAutoSizeTextMontserrat(
                                          text: '(Ended)',
                                          fontSize: 12,
                                          textColor: Colors.red,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              !listToShow[i].meetingStarted! &&
                                      !listToShow[i].meetingEnded!
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Radio(
                                              activeColor: const Color.fromARGB(
                                                  255, 114, 114, 114),
                                              value: true,
                                              groupValue: true,
                                              onChanged: (val) {}),
                                        ),
                                        CustomAutoSizeTextMontserrat(
                                          text: 'Not Started',
                                          fontSize: 14,
                                          textColor: const Color.fromARGB(
                                              255, 114, 114, 114),
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                          const Spacer(),

                          // InkWell(
                          //     onTap: () {
                          //       innerSetState(() {
                          //         if (menu == false) {
                          //           menu = true;
                          //         } else {
                          //           menu = false;
                          //         }
                          //       });
                          //     },
                          //     child: Container(
                          //         width: 40,
                          //         child: const Icon(Icons.more_vert_rounded)))
                        ],
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "${listToShow[i].nameOfTheMeeting}",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        textColor: ThemeConstants.TextColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "${listToShow[i].meetingType}",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        textColor: ThemeConstants.TextColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "${listToShow[i].dateOfMeeting}",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        textColor: ThemeConstants.TextColor,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              // color: Colors.amber,
                              height: 50,
                              width: 150,
                              child: Stack(
                                //alignment:new Alignment(x, y)
                                children: [
                                  // Expanded(
                                  //     child: ListView.builder(
                                  //         itemCount: itemcount(indexs),

                                  //         itemBuilder: (context, index) {
                                  //           return Positioned(
                                  //             left: 25.0,
                                  //             child: Container(
                                  //               height: 36.0,
                                  //               width: 36.0,
                                  //               decoration: BoxDecoration(
                                  //                 color: Color(0xFFFEF0F0),
                                  //                 shape: BoxShape.circle,
                                  //                 border: Border.all(
                                  //                     color: Color(0xFFFF7171)),
                                  //               ),
                                  //               child: Center(
                                  //                   child: CustomAutoSizeTextMontserrat(
                                  //                       text:
                                  //                           "${controller.listToShow[indexs].siecParticipants![index].name!.substring(0, 1)}")),
                                  //             ),
                                  //           );
                                  //         })),
                                  // Icon(Icons.monetization_on,
                                  //     size: 36.0,
                                  //     color: Color.fromRGBO(218, 165, 32, 1.0)),

                                  ...getlist(i),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          CustomButton(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 225, 150),
                              text: 'Reshedule',
                              textColor: ThemeConstants.blackcolor,
                              onPressed: () async {
                                late bool showTheStartEndOptions;
                                listToShow[i]
                                    .meetingCoordinator!
                                    .forEach((element) {
                                  if (element.id ==
                                          Get.find<BaseController>().id ||
                                      listToShow[i].createdBy ==
                                          Get.find<BaseController>().id) {
                                    showTheStartEndOptions = true;
                                  } else {
                                    print('${element.id}dddddddd');
                                    showTheStartEndOptions = false;
                                  }
                                });
                                if (showTheStartEndOptions == true) {
                                  if (listToShow[i].meetingStarted == false &&
                                      listToShow[i].meetingEnded == false) {
                                    showAnimatedDialog(
                                        animationType: DialogTransitionType
                                            .slideFromBottomFade,
                                        curve: Curves.easeInOutQuart,
                                        // barrierDismissible: false,
                                        context: context,
                                        builder: (ctx) =>
                                            ResheduleMeetingDialogue(
                                              controller: Get.find<
                                                  DashBoardController>(),
                                              indexz: i,
                                              meetingData: listToShow[i],
                                            ));
                                  } else {
                                    showAnimatedDialog(
                                        animationType: DialogTransitionType
                                            .slideFromBottomFade,
                                        curve: Curves.easeInOutQuart,
                                        // barrierDismissible: false,
                                        context: context,
                                        builder: (ctx) => showPoPUp(
                                            'Meeting already started',
                                            Icon(
                                              Icons.error,
                                              size: 50,
                                              color: ThemeConstants.bluecolor,
                                            )));
                                  }
                                } else {
                                  showAnimatedDialog(
                                      animationType: DialogTransitionType
                                          .slideFromBottomFade,
                                      curve: Curves.easeInOutQuart,
                                      // barrierDismissible: false,
                                      context: context,
                                      builder: (ctx) => showPoPUp(
                                          "Only Co-ordinator's and creator can reshedule the meeting",
                                          Icon(
                                            Icons.error,
                                            size: 50,
                                            color: ThemeConstants.bluecolor,
                                          )));
                                }
                              }),
                          // CustomButton(text: 'Delete', onPressed: () {})
                        ],
                      )
                    ],
                  ),
                  // if (menu == true)
                  //   Positioned(
                  //       right: 25,
                  //       top: -2,
                  //       child: SizedBox(
                  //         height: 70,
                  //         width: 155,
                  //         child: Opacity(
                  //           opacity: 1,
                  //           child: Card(
                  //             elevation: 2,
                  //             color: Colors.white,
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const Spacer(),
                  //                 InkWell(
                  //                   onTap: () async {
                  //                     // if (controller.listToShow[indexs]
                  //                     //             .meetingStarted ==
                  //                     //         false &&
                  //                     //     controller.listToShow[indexs]
                  //                     //             .meetingEnded ==
                  //                     //         false) {
                  //                     showAnimatedDialog(
                  //                         animationType: DialogTransitionType
                  //                             .slideFromBottomFade,
                  //                         curve: Curves.easeInOutQuart,
                  //                         // barrierDismissible: false,
                  //                         context: context,
                  //                         builder: (ctx) =>
                  //                             ResheduleMeetingDialogue(
                  //                               controller: controller,
                  //                               indexz: indexs,
                  //                               meetingData:
                  //                                   controller.listToShow[indexs],
                  //                             ));
                  //                     // } else {
                  //                     // showAnimatedDialog(
                  //                     //     animationType: DialogTransitionType
                  //                     //         .slideFromBottomFade,
                  //                     //     curve: Curves.easeInOutQuart,
                  //                     //     // barrierDismissible: false,
                  //                     //     context: context,
                  //                     //     builder: (ctx) => AlertDialog(
                  //                     //           content: Container(
                  //                     //               width: 400,
                  //                     //               height: 400,
                  //                     //               child:
                  //                     //                   CustomAutoSizeTextMontserrat(
                  //                     //                 text:
                  //                     //                     'Meeting already started',
                  //                     //               )),
                  //                     //         ));
                  //                     // }

                  //                     // rescheduleMeetingDialogue(
                  //                     //     context: context,
                  //                     //     id: controller.listToShow[indexs].id!,
                  //                     //     timeCallback: (data2) {
                  //                     //       AllMeetings data =
                  //                     //           controller.listToShow[indexs];

                  //                     //       data.timeOfTheMeeting = data2;
                  //                     //       data.isReschedule = true;
                  //                     //       print(data.toJson());
                  //                     //       /
                  //                     //     });
                  //                   },
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 10),
                  //                     child: CustomAutoSizeTextMontserrat(
                  //                       text: "Reschedule Meeting",
                  //                       fontSize: 10,
                  //                       fontWeight: FontWeight.w600,
                  //                       textColor: ThemeConstants.TextColor,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 InkWell(
                  //                   onTap: () async {
                  //                     showAnimatedDialog(
                  //                         animationType: DialogTransitionType
                  //                             .slideFromBottomFade,
                  //                         curve: Curves.easeInOutQuart,
                  //                         // barrierDismissible: false,
                  //                         context: context,
                  //                         builder: (ctx) => AlertDialog(
                  //                               content: Container(
                  //                                 width: 300,
                  //                                 height: 100,
                  //                                 child: Column(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment
                  //                                             .center,
                  //                                     crossAxisAlignment:
                  //                                         CrossAxisAlignment
                  //                                             .center,
                  //                                     children: [
                  //                                       CustomAutoSizeTextMontserrat(
                  //                                         text: 'Please Confirm',
                  //                                         fontSize: 25,
                  //                                       ),
                  //                                       InkWell(
                  //                                         onTap: () {},
                  //                                         child: CustomButton(
                  //                                           backgroundColor:
                  //                                               ThemeConstants
                  //                                                   .bluecolor,
                  //                                           onPressed: () {},
                  //                                           text: 'Delete',
                  //                                         ),
                  //                                       )
                  //                                     ]),
                  //                               ),
                  //                             ));
                  //                   },
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 10),
                  //                     child: CustomAutoSizeTextMontserrat(
                  //                       text: "Delete Meeting",
                  //                       fontSize: 10,
                  //                       fontWeight: FontWeight.w600,
                  //                       textColor: ThemeConstants.TextColor,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const Spacer(),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       )),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    return data;
    // // Padding(
    //   padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
    //   child: Container(
    //     width: MediaQuery.of(context).size.width,
    //     decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //           begin: Alignment.centerLeft,
    //           end: Alignment.centerRight,
    //           colors: [
    //             Color.fromARGB(255, 255, 225, 150),
    //             Color.fromARGB(255, 255, 225, 150),
    //             Color.fromARGB(255, 255, 255, 255)
    //           ],
    //           stops: [0.00, 0.05, 0.05],
    //         ),
    //         border: Border.all(color: const Color(0xff1940b3)),
    //         borderRadius: BorderRadius.circular(10.0)),
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 25, top: 8),
    //       child: Stack(
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   InkWell(
    //                     onTap: () {
    //                       controller.getNotes(
    //                           '${controller.listToShow[indexs].id}', indexs);
    //                       Get.to(MeetingDetails());
    //                       // Get.toNamed(MeetingDetails.routeNamed,
    //                       //     arguments: controller.listToShow[indexs]);
    //                     },
    //                     child: SizedBox(
    //                       width: 300,
    //                       child: CustomAutoSizeTextMontserrat(
    //                         text:
    //                             "${controller.listToShow[indexs].meetingAgenda}",
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                     ),
    //                   ),
    //                   const Spacer(),

    //                   // InkWell(
    //                   //     onTap: () {
    //                   //       innerSetState(() {
    //                   //         if (menu == false) {
    //                   //           menu = true;
    //                   //         } else {
    //                   //           menu = false;
    //                   //         }
    //                   //       });
    //                   //     },
    //                   //     child: Container(
    //                   //         width: 40,
    //                   //         child: const Icon(Icons.more_vert_rounded)))
    //                 ],
    //               ),
    //               CustomAutoSizeTextMontserrat(
    //                 text: "${controller.listToShow[indexs].nameOfTheMeeting}",
    //                 fontSize: 13,
    //                 fontWeight: FontWeight.w600,
    //                 textColor: ThemeConstants.TextColor,
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               CustomAutoSizeTextMontserrat(
    //                 text: "${controller.listToShow[indexs].meetingType}",
    //                 fontSize: 13,
    //                 fontWeight: FontWeight.w600,
    //                 textColor: ThemeConstants.TextColor,
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               CustomAutoSizeTextMontserrat(
    //                 text: "${controller.listToShow[indexs].dateOfMeeting}",
    //                 fontSize: 13,
    //                 fontWeight: FontWeight.w600,
    //                 textColor: ThemeConstants.TextColor,
    //               ),
    //               Row(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 20),
    //                     child: SizedBox(
    //                       // color: Colors.amber,
    //                       height: 50,
    //                       width: 150,
    //                       child: Stack(
    //                         //alignment:new Alignment(x, y)
    //                         children: [
    //                           // Expanded(
    //                           //     child: ListView.builder(
    //                           //         itemCount: itemcount(indexs),

    //                           //         itemBuilder: (context, index) {
    //                           //           return Positioned(
    //                           //             left: 25.0,
    //                           //             child: Container(
    //                           //               height: 36.0,
    //                           //               width: 36.0,
    //                           //               decoration: BoxDecoration(
    //                           //                 color: Color(0xFFFEF0F0),
    //                           //                 shape: BoxShape.circle,
    //                           //                 border: Border.all(
    //                           //                     color: Color(0xFFFF7171)),
    //                           //               ),
    //                           //               child: Center(
    //                           //                   child: CustomAutoSizeTextMontserrat(
    //                           //                       text:
    //                           //                           "${controller.listToShow[indexs].siecParticipants![index].name!.substring(0, 1)}")),
    //                           //             ),
    //                           //           );
    //                           //         })),
    //                           // Icon(Icons.monetization_on,
    //                           //     size: 36.0,
    //                           //     color: Color.fromRGBO(218, 165, 32, 1.0)),

    //                           ...getlist(indexs),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Spacer(),
    //                   CustomButton(
    //                       backgroundColor: Color.fromARGB(255, 255, 225, 150),
    //                       text: 'Reshedule',
    //                       textColor: ThemeConstants.blackcolor,
    //                       onPressed: () {
    //                         if (controller.listToShow[indexs].meetingStarted ==
    //                                 false &&
    //                             controller.listToShow[indexs].meetingEnded ==
    //                                 false) {
    //                           showAnimatedDialog(
    //                               animationType:
    //                                   DialogTransitionType.slideFromBottomFade,
    //                               curve: Curves.easeInOutQuart,
    //                               // barrierDismissible: false,
    //                               context: context,
    //                               builder: (ctx) => ResheduleMeetingDialogue(
    //                                     controller: controller,
    //                                     indexz: indexs,
    //                                     meetingData:
    //                                         controller.listToShow[indexs],
    //                                   ));
    //                         } else {
    //                           showAnimatedDialog(
    //                               animationType:
    //                                   DialogTransitionType.slideFromBottomFade,
    //                               curve: Curves.easeInOutQuart,
    //                               // barrierDismissible: false,
    //                               context: context,
    //                               builder: (ctx) => AlertDialog(
    //                                     content: Container(
    //                                         width: 400,
    //                                         height: 400,
    //                                         child: CustomAutoSizeTextMontserrat(
    //                                           text: 'Meeting already started',
    //                                         )),
    //                                   ));
    //                         }
    //                       }),
    //                   // CustomButton(text: 'Delete', onPressed: () {})
    //                 ],
    //               )
    //             ],
    //           ),
    //           // if (menu == true)
    //           //   Positioned(
    //           //       right: 25,
    //           //       top: -2,
    //           //       child: SizedBox(
    //           //         height: 70,
    //           //         width: 155,
    //           //         child: Opacity(
    //           //           opacity: 1,
    //           //           child: Card(
    //           //             elevation: 2,
    //           //             color: Colors.white,
    //           //             child: Column(
    //           //               mainAxisAlignment: MainAxisAlignment.start,
    //           //               crossAxisAlignment: CrossAxisAlignment.start,
    //           //               children: [
    //           //                 const Spacer(),
    //           //                 InkWell(
    //           //                   onTap: () async {
    //           //                     // if (controller.listToShow[indexs]
    //           //                     //             .meetingStarted ==
    //           //                     //         false &&
    //           //                     //     controller.listToShow[indexs]
    //           //                     //             .meetingEnded ==
    //           //                     //         false) {
    //           //                     showAnimatedDialog(
    //           //                         animationType: DialogTransitionType
    //           //                             .slideFromBottomFade,
    //           //                         curve: Curves.easeInOutQuart,
    //           //                         // barrierDismissible: false,
    //           //                         context: context,
    //           //                         builder: (ctx) =>
    //           //                             ResheduleMeetingDialogue(
    //           //                               controller: controller,
    //           //                               indexz: indexs,
    //           //                               meetingData:
    //           //                                   controller.listToShow[indexs],
    //           //                             ));
    //           //                     // } else {
    //           //                     // showAnimatedDialog(
    //           //                     //     animationType: DialogTransitionType
    //           //                     //         .slideFromBottomFade,
    //           //                     //     curve: Curves.easeInOutQuart,
    //           //                     //     // barrierDismissible: false,
    //           //                     //     context: context,
    //           //                     //     builder: (ctx) => AlertDialog(
    //           //                     //           content: Container(
    //           //                     //               width: 400,
    //           //                     //               height: 400,
    //           //                     //               child:
    //           //                     //                   CustomAutoSizeTextMontserrat(
    //           //                     //                 text:
    //           //                     //                     'Meeting already started',
    //           //                     //               )),
    //           //                     //         ));
    //           //                     // }

    //           //                     // rescheduleMeetingDialogue(
    //           //                     //     context: context,
    //           //                     //     id: controller.listToShow[indexs].id!,
    //           //                     //     timeCallback: (data2) {
    //           //                     //       AllMeetings data =
    //           //                     //           controller.listToShow[indexs];

    //           //                     //       data.timeOfTheMeeting = data2;
    //           //                     //       data.isReschedule = true;
    //           //                     //       print(data.toJson());
    //           //                     //       /
    //           //                     //     });
    //           //                   },
    //           //                   child: Padding(
    //           //                     padding: const EdgeInsets.only(left: 10),
    //           //                     child: CustomAutoSizeTextMontserrat(
    //           //                       text: "Reschedule Meeting",
    //           //                       fontSize: 10,
    //           //                       fontWeight: FontWeight.w600,
    //           //                       textColor: ThemeConstants.TextColor,
    //           //                     ),
    //           //                   ),
    //           //                 ),
    //           //                 InkWell(
    //           //                   onTap: () async {
    //           //                     showAnimatedDialog(
    //           //                         animationType: DialogTransitionType
    //           //                             .slideFromBottomFade,
    //           //                         curve: Curves.easeInOutQuart,
    //           //                         // barrierDismissible: false,
    //           //                         context: context,
    //           //                         builder: (ctx) => AlertDialog(
    //           //                               content: Container(
    //           //                                 width: 300,
    //           //                                 height: 100,
    //           //                                 child: Column(
    //           //                                     mainAxisAlignment:
    //           //                                         MainAxisAlignment
    //           //                                             .center,
    //           //                                     crossAxisAlignment:
    //           //                                         CrossAxisAlignment
    //           //                                             .center,
    //           //                                     children: [
    //           //                                       CustomAutoSizeTextMontserrat(
    //           //                                         text: 'Please Confirm',
    //           //                                         fontSize: 25,
    //           //                                       ),
    //           //                                       InkWell(
    //           //                                         onTap: () {},
    //           //                                         child: CustomButton(
    //           //                                           backgroundColor:
    //           //                                               ThemeConstants
    //           //                                                   .bluecolor,
    //           //                                           onPressed: () {},
    //           //                                           text: 'Delete',
    //           //                                         ),
    //           //                                       )
    //           //                                     ]),
    //           //                               ),
    //           //                             ));
    //           //                   },
    //           //                   child: Padding(
    //           //                     padding: const EdgeInsets.only(left: 10),
    //           //                     child: CustomAutoSizeTextMontserrat(
    //           //                       text: "Delete Meeting",
    //           //                       fontSize: 10,
    //           //                       fontWeight: FontWeight.w600,
    //           //                       textColor: ThemeConstants.TextColor,
    //           //                     ),
    //           //                   ),
    //           //                 ),
    //           //                 const Spacer(),
    //           //               ],
    //           //             ),
    //           //           ),
    //           //         ),
    //           //       )),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  List<Widget> getlist(int indexs) {
    var x = 25.0;
    List<Widget> list = [];
    var count = 0;
    List<Color> colorData = [
      Color(0xFFFF7171),
      Color(0xFF09C964),
      Color(0xFFFF9900),
      Color.fromARGB(255, 0, 102, 255)
    ];

    List<Color> colorDark = [
      Color(0xFFFEF0F0),
      Color(0xFFECFFF5),
      Color(0xFFFEF6E6),
      Color.fromARGB(255, 0, 102, 255)
    ];

    for (var i = 0; i < listToShow[indexs].siecParticipants!.length; i++) {
      if (i < 3) {
        Widget uu = Positioned(
          left: 0 + x * i,
          child: Container(
            height: 36.0,
            width: 36.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Color.fromARGB(87, 0, 0, 0))
              ],
              color: colorDark[i],
              shape: BoxShape.circle,
              border: Border.all(
                color: colorData[i],
              ),
            ),
            child: Center(
                child: CustomAutoSizeTextMontserrat(
                    text:
                        "${listToShow[indexs].siecParticipants![i].name!.substring(0, 1)}")),
          ),
        );

        list.add(uu);
      } else {
        Widget uu = Positioned(
          left: 0 + x * i,
          child: Container(
            height: 36.0,
            width: 36.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Color.fromARGB(87, 0, 0, 0))
              ],
              color: Color(0xFFFEF0F0),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFFF7171)),
            ),
            child: Center(
                child: CustomAutoSizeTextMontserrat(
                    text:
                        "+${listToShow[indexs].siecParticipants!.length - 3}")),
          ),
        );

        list.add(uu);
        break;
      }
    }
    return list;

    //  [
    //   Container(
    //     height: 36.0,
    //     width: 36.0,
    //     decoration: BoxDecoration(
    //         color: Color(0xFFF1F0FF),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFF1940B3))),
    //     child: Center(
    //         child: CustomAutoSizeTextMontserrat(
    //             text:
    //                 "${controller.listToShow[indexs].siecParticipants![0].name!.substring(0, 1)}")),
    //   ),
    //   Positioned(
    //     left: 25.0,
    //     child: Container(
    //       height: 36.0,
    //       width: 36.0,
    //       decoration: BoxDecoration(
    //         color: Color(0xFFFEF0F0),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFFFF7171)),
    //       ),
    //       child: Center(
    //           child: CustomAutoSizeTextMontserrat(
    //               text:
    //                   "${controller.listToShow[indexs].siecParticipants![1].name!.substring(0, 1)}")),
    //     ),
    //   ),
    //   Positioned(
    //     left: 50.0,
    //     child: Container(
    //       height: 36.0,
    //       width: 36.0,
    //       decoration: BoxDecoration(
    //         color: Color(0xFFECFFF5),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFF09C964)),
    //       ),
    //       child: Center(
    //           child: CustomAutoSizeTextMontserrat(
    //               text:
    //                   "${controller.listToShow[indexs].siecParticipants![0].name!.substring(0, 1)}")),
    //     ),
    //   ),
    //   Positioned(
    //     left: 75.0,
    //     child: Container(
    //       height: 36.0,
    //       width: 36.0,
    //       decoration: BoxDecoration(
    //         color: Color(0xFFFEF6E6),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFFFF9900)),
    //       ),
    //       child: Center(child: CustomAutoSizeTextMontserrat(text: "+5")),
    //     ),
    //   ),
    // ];
  }
}
