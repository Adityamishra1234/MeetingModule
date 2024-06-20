import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:location/location.dart';
import 'package:meeting_module2/Bloc_Repo_Field_Activity/Bloc/field_activity_bloc.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/ui/screens/add_institute.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/addRepresentative_widget.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget_pick_hour_minutes.dart';
import 'package:meeting_module2/widget/custom_dialog_box.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:provider/provider.dart';

import '../../Bloc_Repo_Field_Activity/Repo/get_field_activity_repo.dart';
import '../../models/allStatesModel.dart';
import '../../models/searchInstituteModel.dart';

class CreateNewMeeting2 extends StatefulWidget {
  static const routeNamed = 'CreateNewMeeting';

  @override
  State<CreateNewMeeting2> createState() => _CreateNewMeeting2State();
}

class _CreateNewMeeting2State extends State<CreateNewMeeting2> {
  int current = 0;
  File? userImage;
  String? image;

  void getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        userImage = File(pickedFile.path);
        image = userImage.toString();
        print("Image selected, ${userImage.toString()}");
      } else {
        print("Image not selected");
      }
    });
  }

  List<String> meetings = [
    "Internal Meeting",
    "External Meeting",
    "Partnership Program"
  ];
  List<String> icons = [
    "assets/images/group.png",
    "assets/images/branch.png",
    "assets/images/user.png",
    "assets/images/allUser.png",
  ];
  List<String> meetingImages = [
    "assets/images/university.png",
    "assets/images/vendorMeetings.png",
    "assets/images/bankMeetins.png",
  ];
  late CreateNewMeetingController2 controller;
  late FieldActivityBloc bloc;

  @override
  void initState() {
    controller = Get.put(CreateNewMeetingController2());
    bloc = FieldActivityBloc(context.read<FieldActivityRepo>());
    if (current == 1) {
      controller.externalMeeting = true;
      controller.fieldActivity = false;
      controller.update();
    } else if (current == 0) {
      controller.externalMeeting = false;
      controller.fieldActivity = false;
      controller.update();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CreateNewMeetingController2());
    return Scaffold(
        body: controller.obx(
            (state) => PopScope(
                  canPop: true,
                  onPopInvoked: (didPop) {},
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: ThemeConstants.backgroundGradient),
                    padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Create New Meeting",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                            fontSize: 20,
                            color: ThemeConstants.paleYellow,
                            fontWeight: FontWeight.w600,
                          )),
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: meetings.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                        // print(current);
                                      });
                                      if (current == 0) {
                                        setState(() {
                                          controller.externalMeeting = false;
                                          controller.fieldActivity = false;
                                          controller.update();
                                        });
                                      } else if (current == 1) {
                                        setState(() {
                                          controller.externalMeeting = true;
                                          controller.fieldActivity = false;
                                          controller.update();
                                        });
                                      } else if (current == 2) {
                                        setState(() {
                                          controller.fieldActivity = true;
                                          controller.externalMeeting = false;
                                          controller.update();
                                        });
                                      }
                                    },
                                    child: AnimatedContainer(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      height: 55,
                                      decoration: BoxDecoration(
                                          // gradient: current == index ? ThemeConstants.backgroundGradient : LinearGradient(colors: [
                                          //   Colors.white,
                                          //   Colors.white
                                          // ]),
                                          border: current == index
                                              ? Border.all(
                                                  color: Colors.transparent)
                                              : Border.all(
                                                  color: Colors.black12),
                                          color: current == index
                                              ? ThemeConstants.whitecolor
                                              : Color(0x50FFFFFF),
                                          borderRadius: current == index
                                              ? BorderRadius.all(
                                                  Radius.circular(10))
                                              : BorderRadius.all(
                                                  Radius.circular(5),
                                                )),
                                      duration: Duration(milliseconds: 200),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 18.0,
                                            left: 18.0,
                                            top: 10,
                                            bottom: 10),
                                        child: Center(
                                          child: Text(
                                            "${meetings[index]}",
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: current == index
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                            // CustomTabWidget2(
                            //   title0: "Internal Meeting",
                            //   title1: "External Meeting",
                            //   title2: "Field Activity",
                            //   callback: (val) {
                            //     if (val == 1) {
                            //       controller.externalMeeting = true;
                            //       controller.update();
                            //     } else {
                            //       controller.externalMeeting = false;
                            //       controller.update();
                            //     }
                            //   },
                            // ),
                            ),
                        SizedBox(
                          height: 10,
                        ),

                        // if (controller.externalMeeting.value)
                        current == 2
                            ? Expanded(
                                child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeConstants.whitecolor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35))),
                                child: ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  children: [
                                    ...getFieldActivity(context, controller),
                                  ],
                                ),
                              ))
                            : Expanded(
                                child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeConstants.whitecolor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35))),
                                child: ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  children: [
                                    ...getListInternalmeeting(
                                        context, controller),
                                  ],
                                ),
                              ))
                        // if (controller.externalMeeting.value)
                        //   ...getExternalMeeting(context, controller)
                      ],
                    ),
                  ),
                ),
            onLoading: getLoading(context)));
  }

  List<Widget> getFieldActivity(
      //TextEditingControllers should be different for all of the text field inside fieldActivity.
      BuildContext context,
      CreateNewMeetingController2 controllers) {
    var controller = Get.find<CreateNewMeetingController2>();
    return [
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Form(
          key: controller.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.fieldActivity == true) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      mandatory: true,
                      text: "Partner Type",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                    height: 110,
                    child: ListView.builder(
                      itemCount: controller.instituteType.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.typeOfInstitute.value =
                                  controller.instituteType[index];
                            });
                            showAnimatedDialog(
                                animationType:
                                    DialogTransitionType.slideFromBottomFade,
                                context: context,
                                builder: (context) {
                                  return LocationBasedWidget(
                                    controller: controller,
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: 135,
                            height: 110,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigoAccent.withOpacity(0.3),
                                  spreadRadius: -0.2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                )
                              ],
                              color: controller.typeOfInstitute.value ==
                                      controller.instituteType[index]
                                  ? Color(0x803088C6)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                '${controller.instituteType[index]}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: controller.typeOfInstitute.value ==
                                          controller.instituteType[index]
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                // CustomMultiDownSingle(
                //     enableMultiSelect: false,
                //     callbackFunctionSingle: (val) {
                //       controller.typeOfInstitute.value = val;
                //       controller.listOfParticipants = [];
                //       controller.getRepresentativeDropDownData();
                //       print(val);
                //       if (val != "University Meetings") {
                //         controller.fetchParticipantData();
                //       }
                //       controller.inItGetRepresentative();
                //     },
                //     model: controller.instituteType,
                //     initialSelectedValue: '${controllers.typeOfInstitute}'),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          width: 130,
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: CustomAutoSizeTextMontserrat(
                              text: "Add Institute",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await addInstitute(context, controller);

                          //updated add institute here
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => CustomProfileDialogue(
                          //         child: Container(
                          //           child: Column(children: [
                          //             Row(
                          //               children: [
                          //                 CustomButton(text: 'Unive', onPressed: () {}),
                          //                 CustomButton(
                          //                     text: 'Vendor', onPressed: () {}),
                          //                 CustomButton(text: 'Bank', onPressed: () {}),
                          //               ],
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.only(left: 15),
                          //               child: Align(
                          //                 alignment: AlignmentDirectional.topStart,
                          //                 child: CustomAutoSizeTextMontserrat(
                          //                   text: "University",
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold,
                          //                 ),
                          //               ),
                          //             ),
                          //           ]),
                          //         ),
                          //         title: 'Add Representative'));
                        },
                        child: Container(
                          width: 100,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                              color: Color(0xff3088C6),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 16,
                                  color: ThemeConstants.whitecolor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                CustomAutoSizeTextMontserrat(
                                  text: "Add",
                                  textColor: ThemeConstants.whitecolor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // child: CustomAutoSizeTextMontserrat(
                        //   text: "ADD",
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 2),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Name of Partner",
                      mandatory: false,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                //here take name of the partner based on the above type selection
                ValueListenableBuilder(
                  valueListenable: bloc.loadingUniversityNames,
                  builder: (BuildContext context, bool loading, __) {
                    if(loading){
                      return getLoading(context);
                    }
                    return ValueListenableBuilder(
                      valueListenable: bloc.searchedUniversityData,
                      builder: (BuildContext context, SearchInstituteModel model, __) {
                        return Container(
                          child: CustomMultiDownSingle(
                            model: controller.instituteUniversityNames,
                            initialSelectedValue: 'Select Partner',
                            enableMultiSelect: false,
                            callbackFunctionSingle: (Value) {
                              //for selection code here
                            },
                          ),
                        );
                      },
                    );
                  },

                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 2),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Address of visit location",
                      mandatory: false,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  // height: 45,

                  child: CustomTextField(
                      validator: Validator.notEmpty,
                      hint: '',
                      controller: controller.meetingNameController.value),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Date",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width - 30,
                            child: CustomTimerWidget(
                                field: Container(
                                  height: 25,
                                  child: CustomTextField(
                                    forDropDown: false,
                                    backgroundCOlour: Colors.transparent,
                                    hint: '',
                                    readOrEdit: true,
                                    controller: TextEditingController(),
                                    validator:
                                        controller.dateController.value == ''
                                            ? Validator.plzSelectOne
                                            : null,
                                  ),
                                ),
                                startingDate:
                                    DateTime.now().subtract(Duration(days: 30)),
                                isBlank: true,
                                callback: (val) {
                                  controller.dateController.value = val;

                                  print(controller.dateController.value);
                                })),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Time",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              height: 65,
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              child: CustomTimerWidget2(
                                field: Container(
                                  height: 22,
                                  child: CustomTextField(
                                    forDropDown: false,
                                    backgroundCOlour: Colors.transparent,
                                    hint: '',
                                    readOrEdit: true,
                                    controller: TextEditingController(),
                                    validator:
                                        controller.timeController.value == ''
                                            ? Validator.plzSelectOne
                                            : null,
                                  ),
                                ),
                                callback: (val) {
                                  print(val);
                                  // print(val);
                                  controller.timeController.value = val;

                                  print(controller.timeController.value);
                                },
                                isBlank: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Proposed Duration",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              height: 65,
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 2,
                              child: CustomTimerWidgetForHourMinutes(
                                  field: Container(
                                    height: 22,
                                    child: CustomTextField(
                                      forDropDown: false,
                                      backgroundCOlour: Colors.transparent,
                                      hint: '',
                                      readOrEdit: true,
                                      controller: TextEditingController(),
                                      validator: controller
                                                  .proposedDurationController
                                                  .value ==
                                              '0 hours 0 minutes'
                                          ? Validator.plzSelectOne
                                          : null,
                                    ),
                                  ),
                                  callback: (val) async {
                                    // var hours = int.parse(val) / 60;
                                    // var minutes = int.parse(val) % 60;

                                    print(val);

                                    var data = val.toString();

                                    var time =
                                        '${data.substring(0, 2)} hours ${data.substring(3, 5)} minutes';

                                    print(time);

                                    // print(val);
                                    controller.proposedDurationController
                                        .value = time;
                                    // controller.update();
                                    // print(controller.proposedDurationController.value);
                                  }),
                            ),
                          ),
                        ),

                        // Align(
                        //   alignment: AlignmentDirectional.topStart,
                        //   child: Container(
                        //       height: 45,
                        //       width: (MediaQuery.of(context).size.width - 40) / 2,
                        //       // decoration: BoxDecoration(
                        //       //     color: ThemeConstants.lightgreycolor,
                        //       //     borderRadius:
                        //       //         const BorderRadius.all(Radius.circular(10.0))),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //             decoration: BoxDecoration(
                        //                 color: ThemeConstants.lightVioletColor,
                        //                 borderRadius: BorderRadius.circular(15)),
                        //             width:
                        //                 (MediaQuery.of(context).size.width - 40) /
                        //                     4.5,
                        //             child: TextFormField(
                        //               keyboardType: TextInputType.number,
                        //               decoration: InputDecoration(
                        //                 contentPadding: EdgeInsets.symmetric(
                        //                     vertical: 10, horizontal: 15),
                        //                 hintText: 'Hours',
                        //                 filled: true,
                        //                 fillColor: ThemeConstants.lightblueColor,
                        //                 border: OutlineInputBorder(
                        //                   borderSide: BorderSide.none,
                        //                   borderRadius: BorderRadius.circular(15.0),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 5,
                        //           ),
                        //           Container(
                        //             decoration: BoxDecoration(
                        //                 color: ThemeConstants.lightVioletColor,
                        //                 borderRadius: BorderRadius.circular(15)),
                        //             width:
                        //                 (MediaQuery.of(context).size.width - 40) /
                        //                     4.5,
                        //             child: TextFormField(
                        //               keyboardType: TextInputType.number,
                        //               decoration: InputDecoration(
                        //                 contentPadding: EdgeInsets.symmetric(
                        //                     vertical: 10, horizontal: 15),
                        //                 hintText: 'Minutes',
                        //                 filled: true,
                        //                 fillColor: ThemeConstants.lightblueColor,
                        //                 border: OutlineInputBorder(
                        //                   borderSide: BorderSide.none,
                        //                   borderRadius: BorderRadius.circular(15.0),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       )),
                        // ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child:
                          // CustomTextField(
                          //   hint: 'Creat',
                          //   controller: controller.meetingNameController.value,
                          // ),
                          CustomAutoSizeTextMontserrat(
                        text: "Agenda of Visit / Purpose",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xff3088C6),
                      child: IconButton(
                        iconSize: 15,
                        onPressed: () {
                          showAnimatedDialog(
                              duration: Duration(milliseconds: 350),
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              context: context,
                              builder: (_) => Stack(children: [
                                    Center(
                                        child: AlertDialog(
                                      contentPadding: EdgeInsets.all(30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomAutoSizeTextMontserrat(
                                                text: 'Add new Agenda'),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            Container(
                                              // height: 45,

                                              child: CustomTextField(
                                                  validator: Validator.notEmpty,
                                                  hint: '',
                                                  controller: controller
                                                      .addNewAgendaController
                                                      .value),
                                            ),
                                            CustomButton(
                                                backgroundColor:
                                                    Color(0xff3088C6),
                                                text: ' Add Agenda   ',
                                                onPressed: () async {
                                                  if (controller
                                                          .addNewAgendaController
                                                          .value
                                                          .text ==
                                                      '') {
                                                    getToast(
                                                        'Add a valid agenda');
                                                  } else {
                                                    var data = await controller
                                                        .addNewAgenda(
                                                            agenda: controller
                                                                .addNewAgendaController
                                                                .value
                                                                .text,
                                                            userId: Get.find<
                                                                    BaseController>()
                                                                .id);

                                                    if (data) {
                                                      context.pop();
                                                    }
                                                  }
                                                })
                                          ],
                                        ),
                                      ),
                                    )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.pop();
                                            // Get.back();
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xff3088C6),
                                                borderRadius:
                                                    BorderRadius.circular(200)),
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: ThemeConstants.whitecolor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]));
                        },
                        icon: Icon(
                          Icons.add,
                          color: ThemeConstants.whitecolor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                if (controller.agendaList.length == 0) ...[
                  Container(),
                ] else ...[
                  Container(
                      child: CustomMultiDownSingle(
                    model: controller.agendaList,
                    initialSelectedValue: controller.agendaList[0],
                    enableMultiSelect: false,
                    callbackFunctionSingle: (Value) {
                      controller.agendaPurposeOfMeeting.value = Value;
                    },
                  )

                      // DropdownButton2(
                      //   underline: Container(),
                      //   buttonStyleData: ButtonStyleData(
                      //       elevation: 0,
                      //       height: 40,
                      //       width: MediaQuery.of(context).size.width,
                      //       decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           borderRadius: BorderRadius.circular(20),
                      //           border:
                      //               Border.all(width: 1, color: ThemeConstants.blackcolor))),
                      //   dropdownStyleData: DropdownStyleData(elevation: 1),
                      //   hint: Text(
                      //     '${controller.agendaPurposeOfMeeting.value}',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: Theme.of(context).hintColor,
                      //     ),
                      //   ),

                      //   items: list
                      //       .map((item) => DropdownMenuItem<String>(
                      //             value: item,
                      //             child: Text(
                      //               item,
                      //               style: const TextStyle(
                      //                 fontSize: 14,
                      //               ),
                      //             ),
                      //           ))
                      //       .toList(),
                      //   value: controller.agendaPurposeOfMeeting.value == null
                      //       ? selectedValue
                      //       : controller.agendaPurposeOfMeeting.value,
                      //   onChanged: (value) {
                      //     // controller.frfr(value);

                      //     controller.agendaPurposeOfMeeting.value = value.toString();

                      //     // controller.changeInFilter();

                      //     controller.update();

                      //     // controller.showSpecificMeeting(value);
                      //   },
                      //   // buttonHeight: 40,
                      //   // buttonWidth: 140,
                      //   // itemHeight: 40,
                      //   // itemWidth: 140,
                      // ),
                      ),
                ],
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text:
                          "Do you have the details of representative you're visiting?",
                      mandatory: false,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                        value: true,
                        groupValue: controller.MeetingType.value,
                        onChanged: (value) {
                          controller.MeetingType.value = true;
                          controller.meetingLocation = null;
                          print(controller.meetingLocation);
                          controller.update();
                        }),
                    CustomAutoSizeTextMontserrat(
                      text: 'YES',
                      fontSize: 10,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Radio(
                        value: false,
                        groupValue: controller.MeetingType.value,
                        onChanged: (value) {
                          controller.MeetingType.value = false;
                          controller.fetchParticipantData();
                          // controller.selectedOption = 1;
                          controller.update();
                        }),
                    CustomAutoSizeTextMontserrat(
                      text: 'NO',
                      fontSize: 10,
                    ),
                  ],
                ),
                if (controller.MeetingType.value == true) ...[
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 2),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name",
                        mandatory: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    // height: 45,

                    child: CustomTextField(
                        keybord: TextInputType.name,
                        validator: Validator.notEmpty,
                        hint: '',
                        controller: controller.meetingNameController.value),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Designation",
                        mandatory: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    // height: 45,

                    child: CustomTextField(
                        keybord: TextInputType.text,
                        validator: Validator.notEmpty,
                        hint: '',
                        controller: controller.meetingNameController.value),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Email ID",
                        mandatory: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    // height: 45,

                    child: CustomTextField(
                        keybord: TextInputType.emailAddress,
                        validator: Validator.notEmpty,
                        hint: '',
                        controller: controller.meetingNameController.value),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Personal Email ID",
                        mandatory: false,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    // height: 45,

                    child: CustomTextField(
                        keybord: TextInputType.emailAddress,
                        // validator: Validator.email,
                        hint: '',
                        controller: controller.meetingNameController.value),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Mobile Number",
                        mandatory: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    // height: 45,

                    child: CustomTextField(
                        keybord: TextInputType.number,
                        validator: Validator.notEmpty,
                        hint: '',
                        controller: controller.meetingNameController.value),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomAutoSizeTextMontserrat(
                                text: "Upload Business Card",
                                mandatory: true,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(0xff3088C6),
                                child: IconButton(
                                  iconSize: 15,
                                  onPressed: () async {
                                    getImage();
                                    // final ImagePicker _picker = ImagePicker();
                                    // final XFile? image =
                                    //     await _picker.pickImage(
                                    //     source: ImageSource.gallery);
                                    // if (image != null) {
                                    //   setState(() {
                                    //     userImage = File(image.path);
                                    //   });
                                    // }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: ThemeConstants.whitecolor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (image != null)
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 2),
                              height: 110,
                              child: Image.file(
                                userImage!,
                                height: 130,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  //add file picker code here

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Row(
                        children: [
                          CustomAutoSizeTextMontserrat(
                            text: "Upload Pamphlet / Brochure",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xff3088C6),
                            child: IconButton(
                              iconSize: 15,
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: ThemeConstants.whitecolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //add file picker code here!
                ],

                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (controller.key.currentState!.validate()) {
                      print(controller.externalMeeting);
                      if (controller.externalMeeting == false) {
                        controller.createNewMeeting(context);
                      } else {
                        controller.createExternalNewMeeting(context);
                      }
                      controller.key.currentState!.save();
                    } else {
                      getToast('${SnackBarConstants.requiredFields}');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: ThemeConstants.backgroundGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: -0.2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: CustomAutoSizeTextMontserrat(
                          text: "Submit",
                          textColor: ThemeConstants.whitecolor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                )
              ],
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> getListInternalmeeting(
      BuildContext context, CreateNewMeetingController2 controllers) {
    var controller = Get.find<CreateNewMeetingController2>();

    String? selectedValue = 'All Meetings';
    bool showFilterList = true;
    List<String> list = <String>[
      'All Meetings',
      'Launch of New program',
      'Training',
      'Networking',
      'Institute Partner meet'
    ];

    return [
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Form(
            key: controller.key,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (controller.externalMeeting == true) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Meeting with",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    //This is a list for Meeting with.

                    SizedBox(
                        height: 110,
                        child: ListView.builder(
                          itemCount: 3,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                controller.meetingWith.value =
                                    controller.meetingWithList[index];
                                controller.listOfParticipants = [];
                                controller.getRepresentativeDropDownData();
                                // print(val);
                                if (controller.meetingWithList[index] !=
                                    "University Meetings") {
                                  controller.fetchParticipantData();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: 135,
                                height: 110,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.indigoAccent.withOpacity(0.3),
                                      spreadRadius: -0.2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                  color: controller.meetingWith.value ==
                                          controller.meetingWithList[index]
                                      ? Color(0x803088C6)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "${meetingImages[index]}",
                                      scale: 12,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${controller.meetingWithList[index]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: controller.meetingWith.value ==
                                                controller
                                                    .meetingWithList[index]
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),

                    //current
                    // CustomMultiDownSingle(
                    //     enableMultiSelect: false,
                    //     callbackFunctionSingle: (val) {
                    //       controller.meetingWith.value = val;
                    //       controller.listOfParticipants = [];
                    //       controller.getRepresentativeDropDownData();
                    //       print(val);
                    //       if (val != "University Meetings") {
                    //         controller.fetchParticipantData();
                    //       }
                    //       // controller.inItGetRepresentative();
                    //     },
                    //     model: controller.meetingWithList,
                    //     initialSelectedValue: '${controllers.meetingWith}'),
                    SizedBox(
                      height: 10,
                    )
                  ],
                  // if (current == 2 && controller.fieldActivity == true) ...[
                  //   Padding(
                  //     padding: const EdgeInsets.only(bottom: 8),
                  //     child: Align(
                  //       alignment: AlignmentDirectional.topStart,
                  //       child: CustomAutoSizeTextMontserrat(
                  //         text: "Meeting with",
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  //
                  //   //current
                  //   CustomMultiDownSingle(
                  //       enableMultiSelect: false,
                  //       callbackFunctionSingle: (val) {
                  //         controller.meetingWith.value = val;
                  //         controller.listOfParticipants = [];
                  //         controller.getRepresentativeDropDownData();
                  //         print(val);
                  //         if (val != "University Meetings") {
                  //           controller.fetchParticipantData();
                  //         }
                  //         // controller.inItGetRepresentative();
                  //       },
                  //       model: controller.meetingWithList,
                  //       initialSelectedValue: '${controllers.meetingWith}'),
                  //   SizedBox(
                  //     height: 10,
                  //   )
                  // ],
                  Row(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child:
                            // CustomTextField(
                            //   hint: 'Creat',
                            //   controller: controller.meetingNameController.value,
                            // ),
                            CustomAutoSizeTextMontserrat(
                          text: "Agenda/Purpose of the Meeting",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xff3088C6),
                        child: IconButton(
                          iconSize: 15,
                          onPressed: () {
                            showAnimatedDialog(
                                duration: Duration(milliseconds: 350),
                                animationType:
                                    DialogTransitionType.slideFromBottomFade,
                                context: context,
                                builder: (_) => Stack(children: [
                                      Center(
                                          child: AlertDialog(
                                        contentPadding: EdgeInsets.all(30),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        content: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomAutoSizeTextMontserrat(
                                                  text: 'Add new Agenda'),
                                              SizedBox(
                                                height: 18,
                                              ),
                                              Container(
                                                // height: 45,

                                                child: CustomTextField(
                                                    validator:
                                                        Validator.notEmpty,
                                                    hint: '',
                                                    controller: controller
                                                        .addNewAgendaController
                                                        .value),
                                              ),
                                              CustomButton(
                                                  backgroundColor:
                                                      Color(0xff3088C6),
                                                  text: ' Add Agenda   ',
                                                  onPressed: () async {
                                                    if (controller
                                                            .addNewAgendaController
                                                            .value
                                                            .text ==
                                                        '') {
                                                      getToast(
                                                          'Add a valid agenda');
                                                    } else {
                                                      var data = await controller
                                                          .addNewAgenda(
                                                              agenda: controller
                                                                  .addNewAgendaController
                                                                  .value
                                                                  .text,
                                                              userId: Get.find<
                                                                      BaseController>()
                                                                  .id);

                                                      if (data) {
                                                        context.pop();
                                                      }
                                                    }
                                                  })
                                            ],
                                          ),
                                        ),
                                      )),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: GestureDetector(
                                            onTap: () {
                                              context.pop();
                                              // Get.back();
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff3088C6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200)),
                                              child: Icon(
                                                Icons.close_rounded,
                                                color:
                                                    ThemeConstants.whitecolor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]));
                          },
                          icon: Icon(
                            Icons.add,
                            color: ThemeConstants.whitecolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (controller.agendaList.length == 0) ...[
                    Container(),
                  ] else ...[
                    Container(
                        child: CustomMultiDownSingle(
                      model: controller.agendaList,
                      initialSelectedValue: controller.agendaList[0],
                      enableMultiSelect: false,
                      callbackFunctionSingle: (Value) {
                        controller.agendaPurposeOfMeeting.value = Value;
                      },
                    )

                        // DropdownButton2(
                        //   underline: Container(),
                        //   buttonStyleData: ButtonStyleData(
                        //       elevation: 0,
                        //       height: 40,
                        //       width: MediaQuery.of(context).size.width,
                        //       decoration: BoxDecoration(
                        //           color: Colors.transparent,
                        //           borderRadius: BorderRadius.circular(20),
                        //           border:
                        //               Border.all(width: 1, color: ThemeConstants.blackcolor))),
                        //   dropdownStyleData: DropdownStyleData(elevation: 1),
                        //   hint: Text(
                        //     '${controller.agendaPurposeOfMeeting.value}',
                        //     style: TextStyle(
                        //       fontSize: 14,
                        //       color: Theme.of(context).hintColor,
                        //     ),
                        //   ),

                        //   items: list
                        //       .map((item) => DropdownMenuItem<String>(
                        //             value: item,
                        //             child: Text(
                        //               item,
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //               ),
                        //             ),
                        //           ))
                        //       .toList(),
                        //   value: controller.agendaPurposeOfMeeting.value == null
                        //       ? selectedValue
                        //       : controller.agendaPurposeOfMeeting.value,
                        //   onChanged: (value) {
                        //     // controller.frfr(value);

                        //     controller.agendaPurposeOfMeeting.value = value.toString();

                        //     // controller.changeInFilter();

                        //     controller.update();

                        //     // controller.showSpecificMeeting(value);
                        //   },
                        //   // buttonHeight: 40,
                        //   // buttonWidth: 140,
                        //   // itemHeight: 40,
                        //   // itemWidth: 140,
                        // ),
                        ),
                  ],

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child:
                          // CustomTextField(
                          //   hint: 'Creat',
                          //   controller: controller.meetingNameController.value,
                          // ),
                          CustomAutoSizeTextMontserrat(
                        text: "Meeting Name",
                        mandatory: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Add TextFormFields and ElevatedButton here.

                  Container(
                    // height: 45,

                    child: CustomTextField(
                        validator: Validator.notEmpty,
                        hint: '',
                        controller: controller.meetingNameController.value),
                  ),
                  // Container(
                  //   height: 45,
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   decoration: BoxDecoration(
                  //       color: ThemeConstants.lightgreycolor,
                  //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: CustomAutoSizeTextMontserrat(
                              text: "Date",
                              mandatory: true,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width - 30,
                              child: CustomTimerWidget(
                                  field: Container(
                                    height: 25,
                                    child: CustomTextField(
                                      forDropDown: false,
                                      backgroundCOlour: Colors.transparent,
                                      hint: '',
                                      readOrEdit: true,
                                      controller: TextEditingController(),
                                      validator:
                                          controller.dateController.value == ''
                                              ? Validator.plzSelectOne
                                              : null,
                                    ),
                                  ),
                                  startingDate: DateTime.now()
                                      .subtract(Duration(days: 30)),
                                  isBlank: true,
                                  callback: (val) {
                                    controller.dateController.value = val;

                                    print(controller.dateController.value);
                                  })),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: CustomAutoSizeTextMontserrat(
                              text: "Time",
                              mandatory: true,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Container(
                                height: 65,
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                        2,
                                child: CustomTimerWidget2(
                                  field: Container(
                                    height: 22,
                                    child: CustomTextField(
                                      forDropDown: false,
                                      backgroundCOlour: Colors.transparent,
                                      hint: '',
                                      readOrEdit: true,
                                      controller: TextEditingController(),
                                      validator:
                                          controller.timeController.value == ''
                                              ? Validator.plzSelectOne
                                              : null,
                                    ),
                                  ),
                                  callback: (val) {
                                    print(val);
                                    // print(val);
                                    controller.timeController.value = val;

                                    print(controller.timeController.value);
                                  },
                                  isBlank: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: CustomAutoSizeTextMontserrat(
                              text: "Proposed Duration",
                              mandatory: true,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Container(
                                height: 65,
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                        2,
                                child: CustomTimerWidgetForHourMinutes(
                                    field: Container(
                                      height: 22,
                                      child: CustomTextField(
                                        forDropDown: false,
                                        backgroundCOlour: Colors.transparent,
                                        hint: '',
                                        readOrEdit: true,
                                        controller: TextEditingController(),
                                        validator: controller
                                                    .proposedDurationController
                                                    .value ==
                                                '0 hours 0 minutes'
                                            ? Validator.plzSelectOne
                                            : null,
                                      ),
                                    ),
                                    callback: (val) async {
                                      // var hours = int.parse(val) / 60;
                                      // var minutes = int.parse(val) % 60;

                                      print(val);

                                      var data = val.toString();

                                      var time =
                                          '${data.substring(0, 2)} hours ${data.substring(3, 5)} minutes';

                                      print(time);

                                      // print(val);
                                      controller.proposedDurationController
                                          .value = time;
                                      // controller.update();
                                      // print(controller.proposedDurationController.value);
                                    }),
                              ),
                            ),
                          ),

                          // Align(
                          //   alignment: AlignmentDirectional.topStart,
                          //   child: Container(
                          //       height: 45,
                          //       width: (MediaQuery.of(context).size.width - 40) / 2,
                          //       // decoration: BoxDecoration(
                          //       //     color: ThemeConstants.lightgreycolor,
                          //       //     borderRadius:
                          //       //         const BorderRadius.all(Radius.circular(10.0))),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //             decoration: BoxDecoration(
                          //                 color: ThemeConstants.lightVioletColor,
                          //                 borderRadius: BorderRadius.circular(15)),
                          //             width:
                          //                 (MediaQuery.of(context).size.width - 40) /
                          //                     4.5,
                          //             child: TextFormField(
                          //               keyboardType: TextInputType.number,
                          //               decoration: InputDecoration(
                          //                 contentPadding: EdgeInsets.symmetric(
                          //                     vertical: 10, horizontal: 15),
                          //                 hintText: 'Hours',
                          //                 filled: true,
                          //                 fillColor: ThemeConstants.lightblueColor,
                          //                 border: OutlineInputBorder(
                          //                   borderSide: BorderSide.none,
                          //                   borderRadius: BorderRadius.circular(15.0),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           Container(
                          //             decoration: BoxDecoration(
                          //                 color: ThemeConstants.lightVioletColor,
                          //                 borderRadius: BorderRadius.circular(15)),
                          //             width:
                          //                 (MediaQuery.of(context).size.width - 40) /
                          //                     4.5,
                          //             child: TextFormField(
                          //               keyboardType: TextInputType.number,
                          //               decoration: InputDecoration(
                          //                 contentPadding: EdgeInsets.symmetric(
                          //                     vertical: 10, horizontal: 15),
                          //                 hintText: 'Minutes',
                          //                 filled: true,
                          //                 fillColor: ThemeConstants.lightblueColor,
                          //                 border: OutlineInputBorder(
                          //                   borderSide: BorderSide.none,
                          //                   borderRadius: BorderRadius.circular(15.0),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       )),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runAlignment: WrapAlignment.spaceBetween,
                        spacing: 20,
                        runSpacing: 5,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Meeting Type",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                      value: true,
                                      groupValue: controller.MeetingType.value,
                                      onChanged: (value) {
                                        controller.MeetingType.value = true;
                                        controller.meetingLocation = null;
                                        print(controller.meetingLocation);
                                        controller.update();
                                      }),
                                  CustomAutoSizeTextMontserrat(
                                    text: 'Online',
                                    fontSize: 10,
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Radio(
                                      value: false,
                                      groupValue: controller.MeetingType.value,
                                      onChanged: (value) {
                                        controller.MeetingType.value = false;
                                        controller.fetchParticipantData();
                                        // controller.selectedOption = 1;
                                        controller.update();
                                      }),
                                  CustomAutoSizeTextMontserrat(
                                    text: 'Offline',
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(),
                              //   child: Align(
                              //       alignment: AlignmentDirectional.topStart,
                              //       child: Container(
                              //           width:
                              //               (MediaQuery.of(context).size.width - 60) / 2,
                              //           child: CustomMultiDownSingle(
                              //               callbackFunctionSingle: (val) {
                              //                 print(val);
                              //                 if (val == 'Offline') {
                              //                   controller.MeetingType.value = false;
                              //                   controller.meetingLocation =
                              //                       true.toString();
                              //                   controller.update();
                              //                 } else {
                              //                   controller.MeetingType.value = true;
                              //                   controller.update();
                              //                 }
                              //               },
                              //               enableMultiSelect: false,
                              //               model: ['Online', 'Offline'],
                              //               initialSelectedValue: 'Online'))),
                              // ),
                            ],
                          ),
                          // Spacer(),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(bottom: 8),
                      //         child: CustomAutoSizeTextMontserrat(
                      //           text: "Meeting Type",
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(),
                      //         child: Align(
                      //             alignment: AlignmentDirectional.topStart,
                      //             child: Container(
                      //                 width:
                      //                     (MediaQuery.of(context).size.width - 60) /
                      //                         2,
                      //                 child: CustomMultiDownSingle(
                      //                     callbackFunctionSingle: (val) {
                      //                       print(val);
                      //                       if (val == 'Offline') {
                      //                         controller.MeetingType.value = false;
                      //                         controller.meetingLocation =
                      //                             true.toString();
                      //                         controller.update();
                      //                       } else {
                      //                         controller.MeetingType.value = true;
                      //                         controller.update();
                      //                       }
                      //                     },
                      //                     enableMultiSelect: false,
                      //                     model: ['Online', 'Offline'],
                      //                     initialSelectedValue: 'Online'))),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  if (controller.MeetingType.value == false) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          spacing: 20,
                          runSpacing: 5,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Location",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio(
                                        value: true.toString(),
                                        groupValue: controller.meetingLocation,
                                        onChanged: (value) {
                                          controller.meetingLocation =
                                              true.toString();
                                          controller.update();
                                        }),
                                    CustomAutoSizeTextMontserrat(
                                      text: 'Siec Branch',
                                      fontSize: 10,
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Radio(
                                        value: false.toString(),
                                        groupValue: controller.meetingLocation,
                                        onChanged: (value) {
                                          controller.meetingLocation =
                                              false.toString();
                                          controller.update();
                                        }),
                                    CustomAutoSizeTextMontserrat(
                                      text: 'Others',
                                      fontSize: 10,
                                    ),
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(),
                                //   child: Align(
                                //       alignment: AlignmentDirectional.topStart,
                                //       child: Container(
                                //           width:
                                //               (MediaQuery.of(context).size.width - 60) / 2,
                                //           child: CustomMultiDownSingle(
                                //               callbackFunctionSingle: (val) {
                                //                 print(val);
                                //                 if (val == 'Offline') {
                                //                   controller.MeetingType.value = false;
                                //                   controller.meetingLocation =
                                //                       true.toString();
                                //                   controller.update();
                                //                 } else {
                                //                   controller.MeetingType.value = true;
                                //                   controller.update();
                                //                 }
                                //               },
                                //               enableMultiSelect: false,
                                //               model: ['Online', 'Offline'],
                                //               initialSelectedValue: 'Online'))),
                                // ),
                              ],
                            ),
                            // Spacer(),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 8),
                    //   child: Align(
                    //     alignment: AlignmentDirectional.topStart,
                    //     child: CustomAutoSizeTextMontserrat(
                    //       text: "Location",
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    // //

                    // Container(
                    //   child: CustomMultiDownSingle(
                    //     enableMultiSelect: false,
                    //     model: ['Siec Branch', 'Others'],
                    //     initialSelectedValue: 'Siec Branch',
                    //     callbackFunctionSingle: (val) {
                    //       print(val);
                    //       if (val == 'Others') {
                    //         controller.meetingLocation = false.toString();
                    //         controller.update();
                    //       }
                    //       if (val == 'Siec Branch') {
                    //         controller.meetingLocation = true.toString();
                    //         controller.update();
                    //       }
                    //     },
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    if (controller.meetingLocation == true.toString()) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Select Branch",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        height: 130,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.branchListwithFlag.length,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    controller.selectMeetingBranch.value =
                                        controller
                                            .branchListwithFlag[index].id!;
                                    controller.update();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    width: 140,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.indigoAccent
                                              .withOpacity(0.3),
                                          spreadRadius: -0.2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 4),
                                        )
                                      ],
                                      color: controller
                                                  .selectMeetingBranch.value ==
                                              controller
                                                  .branchListwithFlag[index].id
                                          ? Color(0x803088C6)
                                          : ThemeConstants.whitecolor,
                                      borderRadius: BorderRadius.circular(15),
                                      // border: Border.all(
                                      //     width: 1,
                                      //     color: ThemeConstants.bluecolor)
                                    ),
                                    // decoration: BoxDecoration(
                                    //     color: controller.selectMeetingBranch
                                    //                 .value ==
                                    //             controller
                                    //                 .branchListwithFlag[index]
                                    //                 .id
                                    //         ? ThemeConstants.lightblueColor2
                                    //         : ThemeConstants.whitecolor,
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     border: Border.all(
                                    //         width: 1,
                                    //         color: ThemeConstants.bluecolor)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .branchListwithFlag[index]
                                                  .imageLink!,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${controller.branchListwithFlag[index].name}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: controller
                                                          .selectMeetingBranch
                                                          .value ==
                                                      controller
                                                          .branchListwithFlag[
                                                              index]
                                                          .id
                                                  ? Colors.white
                                                  : ThemeConstants.blackcolor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ]),
                                  ),
                                )),
                      ),

                      //
                      // Container(
                      //   child: CustomMultiDownSingleAllUser(
                      //     enableMultiSelect: false,
                      //     model: controller.branchList,
                      //     initialSelectedValue: 'Siec Branch',
                      //     callbackFunctionSingle: (AllUserModel val) {
                      //       print('$val ddd');
                      //       controller.selectMeetingBranch.value = val;
                      //       controller.update();
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Specify Location",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        child: CustomTextField(
                            validator: Validator.notEmpty,
                            hint: '',
                            controller:
                                controller.specifyMeetingLocation.value),
                      ),
                    ]
                  ],

                  if (controller.MeetingType.value == true) ...[
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Mode of Meeting",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height: 130,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  controller.modeOfMeeting.value =
                                      controller.modeOfMeetingList[index];

                                  print(controller.modeOfMeeting.value);
                                  // controller.selectMeetingBranch.value =
                                  //     controller.branchListwithFlag[index].id!;
                                  controller.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  width: 135,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.indigoAccent
                                            .withOpacity(0.3),
                                        spreadRadius: -0.2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    color: controller.modeOfMeeting.value ==
                                            controller.modeOfMeetingList[index]
                                        ? Color(0x803088C6)
                                        : ThemeConstants.whitecolor,
                                    borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(
                                    //     width: 1,
                                    //     color: ThemeConstants.bluecolor)
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset(controller
                                              .modeOfMeetingIcon[index]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${controller.modeOfMeetingList[index]}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: controller.modeOfMeeting
                                                          .value ==
                                                      controller
                                                              .modeOfMeetingList[
                                                          index]
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      ]),
                                ),
                              )),
                    ),
                    // CustomMultiDownSingle(
                    //   enableMultiSelect: false,
                    //   model: ['Zoom', 'Meet', 'Teams'],
                    //   initialSelectedValue: 'Zoom',
                    //   callbackFunctionSingle: (val) {
                    //     controller.modeOfMeeting.value = val;
                    //   },
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Meeting Link",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      // height: 45,

                      child: CustomTextField(
                        // validator: controller.MeetingType.value == true
                        //     ? Validator.notEmpty
                        //     : null,
                        hint: '',
                        controller: controller.meetingLink.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Registration Link",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      // height: 45,

                      child: CustomTextField(
                        // validator: controller.MeetingType.value == true
                        //     ? Validator.notEmpty
                        //     : null,
                        hint: '',
                        controller: controller.registrationLink.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],

                  if (controller.externalMeeting == true) ...[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Participants",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // GetX<CreateNewMeetingController>(
                    //     init: CreateNewMeetingController(),
                    //     builder: (controller) {
                    //       if (controller.meetingWith.value == 'University Meetings')
                    //         return Column(
                    //
                    //       children: [

                    SizedBox(
                      height: 10,
                    ),
                    if (controller.meetingWith.value ==
                        'University Meetings') ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Country",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomMultiDownSingleAllUser(
                          model: controller.allCountriesList,
                          initialSelectedValue: '',
                          callbackFunctionSingle: (AllUserModel val) async {
                            if (val.id == 0) return;
                            print(val);
                            controller.selectedCountry = val;
                            await controller.getUniversities(val.id!);
                            controller.selectedUniversity =
                                controller.allUniversityList[0];
                            await controller.getRepresentativesByUniversity();
                            await controller.fetchParticipantData();
                          },
                          callbackFunctionMulti: (AllUserModel val) {
                            print(val);
                          },
                          enableMultiSelect: false),
                      // CustomMultiDownSingleAllUser(
                      //     model: controller.allCountriesList,
                      //     initialSelectedValue: '',
                      //     // inititalSelectedList: controller.preFilledUsers.value,
                      //     callbackFunctionSingle: (val) async {
                      //       controller.selectedCountry.value = val;
                      //       controller.update();
                      //       await controller.getUniversities(
                      //           controller.selectedCountry.value.id!);
                      //       controller.update();
                      //     },
                      //     callbackFunctionMulti: (AllUserModel val) {
                      //       print(val);
                      //     },
                      //     enableMultiSelect: false),

                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "University Name",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      CustomMultiDownSingleAllUser(
                          model: controller.allUniversityList,
                          initialSelectedValue: '',
                          // inititalSelectedList: controller.preFilledUsers.value,
                          callbackFunctionSingle: (val) async {
                            if (val.id == 0) return;
                            controller.selectedUniversity = val;
                            await controller.getRepresentativesByUniversity();

                            controller.update();
                            print(val);
                          },
                          callbackFunctionMulti: (AllUserModel val) {
                            print(val);
                          },
                          enableMultiSelect: false),

                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: SizedBox(
                                width: 200,
                                child: Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Choose Representative",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                addRepresentative(context, controllers);
                                // showDialog(
                                //     context: context,
                                //     builder: (_) => CustomProfileDialogue(
                                //         child: Container(
                                //           child: Column(children: [
                                //             Row(
                                //               children: [
                                //                 CustomButton(text: 'Unive', onPressed: () {}),
                                //                 CustomButton(
                                //                     text: 'Vendor', onPressed: () {}),
                                //                 CustomButton(text: 'Bank', onPressed: () {}),
                                //               ],
                                //             ),
                                //             Padding(
                                //               padding: const EdgeInsets.only(left: 15),
                                //               child: Align(
                                //                 alignment: AlignmentDirectional.topStart,
                                //                 child: CustomAutoSizeTextMontserrat(
                                //                   text: "University",
                                //                   fontSize: 16,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //               ),
                                //             ),
                                //           ]),
                                //         ),
                                //         title: 'Add Representative'));
                              },
                              child: Container(
                                // height: 38,
                                width: 100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Color(0xff3088C6),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 14,
                                        color: ThemeConstants.whitecolor,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      CustomAutoSizeTextMontserrat(
                                        text: "Add New",
                                        textColor: ThemeConstants.whitecolor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // child: CustomAutoSizeTextMontserrat(
                              //   text: "ADD",
                              //   fontSize: 16,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                          ],
                        ),
                      ),
//current   if (controller.meetingWith.value == 'University Meetings') ...[
                      SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8),
                      //   child: Align(
                      //     alignment: AlignmentDirectional.topStart,
                      //     child: CustomAutoSizeTextMontserrat(
                      //       text: "Name of the Person",
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // ],
                      CustomMultiDownSingleAllUser(
                          model: controller.listOfParticipantData,
                          initialSelectedValue: '',
                          // inititalSelectedList: ,
                          callbackFunctionSingle: (val) async {
                            controller.participantID.value = val;
                            await controller.fetchParticipantData();
                            var contains = false;

                            for (var i = 0;
                                i < controller.listOfParticipants.length;
                                i++) {
                              contains = false;
                              if (controller.listOfParticipants[i].id ==
                                  controller.participantData.id) {
                                contains = true;
                              }
                            }
                            print(controller.listOfParticipants);

                            if (contains) {
                              getToast('Already added');
                              // showDialog(
                              //     context: context,
                              //     builder: (_) => AlertDialog(
                              //           content: Container(
                              //               child: Text('Already added')),
                              //         ));
                            } else if (controllers.participantData.id == 0) {
                              // showDialog(
                              //     context: context,
                              //     builder: (_) => AlertDialog(
                              //           content: Container(
                              //               child: Text(
                              //                   'Please add a representative')),
                              //         ));

                              getToast('Kindly add a representative');
                            } else {
                              controller.listOfParticipants
                                  .add(controllers.participantData);
                              controller.update();
                              getToast('Participant updated');
                              // showDialog(
                              //     context: context,
                              //     builder: (_) => AlertDialog(
                              //           shape: RoundedRectangleBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(20)),
                              //           content: Container(
                              //             child: Column(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 children: [
                              //                   Text(
                              //                       'Participant Added Successfully'),
                              //                   Icon(Icons.check_circle,
                              //                       size: 30,
                              //                       color: ThemeConstants
                              //                           .GreenColor)
                              //                 ]),
                              //           ),
                              //         ));
                            }

                            // controller.selectedBranch.value = val;
                            // controller.update();
                          },
                          callbackFunctionMulti: (List<AllUserModel> val) {
                            print(val);
                            // controller.selectedUsersList.value = val;
                            // controller.update();
                          },
                          enableMultiSelect: false),

                      SizedBox(
                        height: 15,
                      ),
                    ],

                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Participants attending meeting",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15),
                    //   child: Align(
                    //     alignment: AlignmentDirectional.topStart,
                    //     child: CustomAutoSizeTextMontserrat(
                    //       text: "Country",
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // CustomMultiDownSingleAllUser(
                    //     model: controller.allCountriesList,
                    //     initialSelectedValue: '',
                    //     // inititalSelectedList: ,
                    //     callbackFunctionSingle: (val) async {
                    //       // controller.selectedBranch.value = val;
                    //       // controller.update();
                    //       print(val);
                    //       controller.selectedCountry.value = val;
                    //       await controller
                    //           .getUniversities(controllers.selectedCountry.value.id!);
                    //       controller.update();
                    //     },
                    //     callbackFunctionMulti: (List<AllUserModel> val) {
                    //       print(val);
                    //       // controller.selectedUsersList.value = val;
                    //       // controller.update();
                    //     },
                    //     enableMultiSelect: false),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15),
                    //   child: Align(
                    //     alignment: AlignmentDirectional.topStart,
                    //     child: CustomAutoSizeTextMontserrat(
                    //       text: "University",
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // CustomMultiDownSingleAllUser(
                    //     model: controller.allUniversityList,
                    //     initialSelectedValue: '',
                    //     // inititalSelectedList: ,
                    //     callbackFunctionSingle: (val) {
                    //       // controller.selectedBranch.value = val;
                    //       // controller.update();
                    //     },
                    //     callbackFunctionMulti: (List<AllUserModel> val) {
                    //       print(val);
                    //       // controller.selectedUsersList.value = val;
                    //       // controller.update();
                    //     },
                    //     enableMultiSelect: false),
                    //       ],
                    //     );
                    //   return Container();
                    // }),

                    if (controller.meetingWith.value == 'Vendor Meeting') ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Name of Vendor",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                addRepresentative(context, controllers);
                                // showDialog(
                                //     context: context,
                                //     builder: (_) => CustomProfileDialogue(
                                //         child: Container(
                                //           child: Column(children: [
                                //             Row(
                                //               children: [
                                //                 CustomButton(text: 'Unive', onPressed: () {}),
                                //                 CustomButton(
                                //                     text: 'Vendor', onPressed: () {}),
                                //                 CustomButton(text: 'Bank', onPressed: () {}),
                                //               ],
                                //             ),
                                //             Padding(
                                //               padding: const EdgeInsets.only(left: 15),
                                //               child: Align(
                                //                 alignment: AlignmentDirectional.topStart,
                                //                 child: CustomAutoSizeTextMontserrat(
                                //                   text: "University",
                                //                   fontSize: 16,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //               ),
                                //             ),
                                //           ]),
                                //         ),
                                //         title: 'Add Representative'));
                              },
                              child: Container(
                                // height: 38,
                                // width: MediaQuery.of(context).size.width * 0.45,
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 10, vertical: 8),
                                // decoration: BoxDecoration(
                                //     color: ThemeConstants.bluecolor,
                                //     borderRadius: const BorderRadius.all(
                                //         Radius.circular(30.0))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Color(0xff3088C6),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 14,
                                        color: ThemeConstants.whitecolor,
                                      ),
                                      CustomAutoSizeTextMontserrat(
                                        text: "Add New",
                                        textColor: ThemeConstants.whitecolor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // child: CustomAutoSizeTextMontserrat(
                              //   text: "ADD",
                              //   fontSize: 16,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                          ],
                        ),
                      ),

                      if (controller.meetingWith.value == 'Vendor Meeting') ...[
                        CustomMultiDownSingleAllUser(
                            model: controller.listOfParticipantData,
                            initialSelectedValue: '',
                            // inititalSelectedList: ,
                            callbackFunctionSingle: (AllUserModel val) async {
                              controller.participantID.value = val;

                              await controller
                                  .fetchReprenestativeDropDownDataFromVendorBankGroup(
                                      "0", '${val.name}');
                              // await controller.fetchParticipantData();

                              // var contains = false;
                              // for (var i = 0;
                              //     i < controller.listOfParticipants.length;
                              //     i++) {
                              //   contains = false;
                              //   if (controller.listOfParticipants[i].id ==
                              //       controller.participantData.id) {
                              //     contains = true;
                              //   }
                              // }

                              // if (contains) {
                              //   getToast('Already updated');
                              //   // showDialog(
                              //   //     context: context,
                              //   //     builder: (_) => AlertDialog(
                              //   //           content: Container(
                              //   //               child: Text('Already added')),
                              //   //         ));
                              // } else if (controllers.participantData.id == 0) {
                              //   // showDialog(
                              //   //     context: context,
                              //   //     builder: (_) => AlertDialog(
                              //   //           content: Container(
                              //   //               child: Text(
                              //   //                   'Please add a representative')),
                              //   //         ));

                              //   getToast('Kindly add a representative');
                              // } else {
                              //   controller.listOfParticipants
                              //       .add(controllers.participantData);
                              //   controller.update();
                              //   getToast('Participant updated');
                              //   // showDialog(
                              //   //     context: context,
                              //   //     builder: (_) => AlertDialog(
                              //   //           shape: RoundedRectangleBorder(
                              //   //               borderRadius:
                              //   //                   BorderRadius.circular(20)),
                              //   //           content: Container(
                              //   //             child: Column(
                              //   //                 mainAxisSize: MainAxisSize.min,
                              //   //                 children: [
                              //   //                   Text(
                              //   //                       'Participant Added Successfully'),
                              //   //                   Icon(Icons.check_circle,
                              //   //                       size: 30,
                              //   //                       color: ThemeConstants
                              //   //                           .GreenColor)
                              //   //                 ]),
                              //   //           ),
                              //   //         ));
                              // }
                              controller.update();
                              // controller.selectedBranch.value = val;
                              // controller.update();
                            },
                            callbackFunctionMulti: (List<AllUserModel> val) {
                              print(val);
                              // controller.selectedUsersList.value = val;
                              // controller.update();
                            },
                            enableMultiSelect: false)
                      ],

                      SizedBox(
                        height: 15,
                      ),

                      // CustomMultiDownSingleAllUser(
                      //     model: controller.allUniversityList,
                      //     initialSelectedValue: '',
                      //     // inititalSelectedList: ,
                      //     callbackFunctionSingle: (val) {
                      //       // controller.selectedBranch.value = val;
                      //       // controller.update();
                      //     },
                      //     callbackFunctionMulti: (List<AllUserModel> val) {
                      //       print(val);
                      //       // controller.selectedUsersList.value = val;
                      //       // controller.update();
                      //     },
                      //     enableMultiSelect: false),
                    ],

                    if (controller.meetingWith.value == 'Bank Meeting') ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Name of Bank",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                addRepresentative(context, controllers);
                                // showDialog(
                                //     context: context,
                                //     builder: (_) => CustomProfileDialogue(
                                //         child: Container(
                                //           child: Column(children: [
                                //             Row(
                                //               children: [
                                //                 CustomButton(text: 'Unive', onPressed: () {}),
                                //                 CustomButton(
                                //                     text: 'Vendor', onPressed: () {}),
                                //                 CustomButton(text: 'Bank', onPressed: () {}),
                                //               ],
                                //             ),
                                //             Padding(
                                //               padding: const EdgeInsets.only(left: 15),
                                //               child: Align(
                                //                 alignment: AlignmentDirectional.topStart,
                                //                 child: CustomAutoSizeTextMontserrat(
                                //                   text: "University",
                                //                   fontSize: 16,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //               ),
                                //             ),
                                //           ]),
                                //         ),
                                //         title: 'Add Representative'));
                              },
                              child: Container(
                                // height: 38,
                                // width: MediaQuery.of(context).size.width * 0.45,
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 10, vertical: 8),
                                // decoration: BoxDecoration(
                                //     color: ThemeConstants.bluecolor,
                                //     borderRadius: const BorderRadius.all(
                                //         Radius.circular(30.0))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Color(0xff3088C6),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 14,
                                        color: ThemeConstants.whitecolor,
                                      ),
                                      CustomAutoSizeTextMontserrat(
                                        text: "Add New",
                                        textColor: ThemeConstants.whitecolor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // child: CustomAutoSizeTextMontserrat(
                              //   text: "ADD",
                              //   fontSize: 16,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.meetingWith.value == 'Bank Meeting') ...[
                        CustomMultiDownSingleAllUser(
                            model: controller.listOfParticipantData,
                            initialSelectedValue: '',
                            // inititalSelectedList: ,
                            callbackFunctionSingle: (val) async {
                              controller.participantID.value = val;

                              await controller
                                  .fetchReprenestativeDropDownDataFromVendorBankGroup(
                                      "1", '${val.name}');

                              controller.fetchParticipantData();
                              // var contains = false;
                              // for (var i = 0;
                              //     i < controller.listOfParticipants.length;
                              //     i++) {
                              //   contains = false;
                              //   if (controller.listOfParticipants[i].id ==
                              //       controller.participantData.id) {
                              //     contains = true;
                              //   }
                              // }

                              // if (contains) {
                              //   getToast('Already added');
                              //   // showDialog(
                              //   //     context: context,
                              //   //     builder: (_) => AlertDialog(
                              //   //           content: Container(
                              //   //               child: Text('Already added')),
                              //   //         ));
                              // } else if (controllers.participantData.id == 0) {
                              //   // showDialog(
                              //   //     context: context,
                              //   //     builder: (_) => AlertDialog(
                              //   //           content: Container(
                              //   //               child: Text(
                              //   //                   'Please add a representative')),
                              //   //         ));

                              //   getToast('Kindly add a representative ');
                              // } else {
                              //   controller.listOfParticipants
                              //       .add(controllers.participantData);
                              //   controller.update();
                              //   getToast('Participant updated');
                              //   // showDialog(
                              //   //     context: context,
                              //   //     builder: (_) => AlertDialog(
                              //   //           shape: RoundedRectangleBorder(
                              //   //               borderRadius:
                              //   //                   BorderRadius.circular(20)),
                              //   //           content: Container(
                              //   //             child: Column(
                              //   //                 mainAxisSize: MainAxisSize.min,
                              //   //                 children: [
                              //   //                   Text(
                              //   //                       'Participant Added Successfully'),
                              //   //                   Icon(Icons.check_circle,
                              //   //                       size: 30,
                              //   //                       color: ThemeConstants
                              //   //                           .GreenColor)
                              //   //                 ]),
                              //   //           ),
                              //   //         ));
                              // }
                              controller.update();
                            },
                            callbackFunctionMulti: (List<AllUserModel> val) {
                              print(val);
                              // controller.selectedUsersList.value = val;
                              // controller.update();
                            },
                            enableMultiSelect: false),
                        SizedBox(
                          height: 10,
                        ),
                      ]
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     controller.showRepresentativeData =
                        //         !controller.showRepresentativeData;

                        //     // showDialog(
                        //     //     context: context,
                        //     //     builder: (_) => DialogHora(controller: controller));
                        //     // controller.listOfParticipants
                        //     //     .add(controllers.participantData.value);
                        //     controller.update();
                        //   },
                        //   child: Container(
                        //     height: 38,
                        //     width: MediaQuery.of(context).size.width * 0.35,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //             width: 1, color: ThemeConstants.orangeColor),
                        //         color: Colors.transparent,
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(30.0))),
                        //     child: Center(
                        //       child: CustomAutoSizeTextMontserrat(
                        //           text: "View Representative Data",
                        //           align: TextAlign.center,
                        //           textColor: ThemeConstants.orangeColor,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   ),
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     showAnimatedDialog(
                        //       context: context,
                        //       builder: (ctx) => ExistingRepresentativeModal(
                        //         controller2: controller,
                        //       ),
                        //     );
                        //     // addRepresentative(context, controllers);
                        //     // showDialog(
                        //     //     context: context,
                        //     //     builder: (_) => CustomProfileDialogue(
                        //     //         child: Container(
                        //     //           child: Column(children: [
                        //     //             Row(
                        //     //               children: [
                        //     //                 CustomButton(text: 'Unive', onPressed: () {}),
                        //     //                 CustomButton(
                        //     //                     text: 'Vendor', onPressed: () {}),
                        //     //                 CustomButton(text: 'Bank', onPressed: () {}),
                        //     //               ],
                        //     //             ),
                        //     //             Padding(
                        //     //               padding: const EdgeInsets.only(left: 15),
                        //     //               child: Align(
                        //     //                 alignment: AlignmentDirectional.topStart,
                        //     //                 child: CustomAutoSizeTextMontserrat(
                        //     //                   text: "University",
                        //     //                   fontSize: 16,
                        //     //                   fontWeight: FontWeight.bold,
                        //     //                 ),
                        //     //               ),
                        //     //             ),
                        //     //           ]),
                        //     //         ),
                        //     //         title: 'Add Representative'));
                        //   },
                        //   child: Container(
                        //     // padding: EdgeInsets.symmetric(horizontal: 10),
                        //     height: 38,
                        //     width: MediaQuery.of(context).size.width * 0.45,
                        //     decoration: BoxDecoration(
                        //         color: ThemeConstants.bluecolor,
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(30.0))),
                        //     child: Center(
                        //       child: CustomAutoSizeTextMontserrat(
                        //         text: "Existing Representative",
                        //         textColor: ThemeConstants.whitecolor,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ),
                        //   // child: CustomAutoSizeTextMontserrat(
                        //   //   text: "ADD",
                        //   //   fontSize: 16,
                        //   //   fontWeight: FontWeight.bold,
                        //   // ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     addRepresentative(context, controllers);
                        //     // showDialog(
                        //     //     context: context,
                        //     //     builder: (_) => CustomProfileDialogue(
                        //     //         child: Container(
                        //     //           child: Column(children: [
                        //     //             Row(
                        //     //               children: [
                        //     //                 CustomButton(text: 'Unive', onPressed: () {}),
                        //     //                 CustomButton(
                        //     //                     text: 'Vendor', onPressed: () {}),
                        //     //                 CustomButton(text: 'Bank', onPressed: () {}),
                        //     //               ],
                        //     //             ),
                        //     //             Padding(
                        //     //               padding: const EdgeInsets.only(left: 15),
                        //     //               child: Align(
                        //     //                 alignment: AlignmentDirectional.topStart,
                        //     //                 child: CustomAutoSizeTextMontserrat(
                        //     //                   text: "University",
                        //     //                   fontSize: 16,
                        //     //                   fontWeight: FontWeight.bold,
                        //     //                 ),
                        //     //               ),
                        //     //             ),
                        //     //           ]),
                        //     //         ),
                        //     //         title: 'Add Representative'));
                        //   },
                        //   child: Container(
                        //     height: 38,
                        //     width: MediaQuery.of(context).size.width * 0.45,
                        //     decoration: BoxDecoration(
                        //         color: ThemeConstants.bluecolor,
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(30.0))),
                        //     child: Center(
                        //       child: CustomAutoSizeTextMontserrat(
                        //         text: "Add New Representative",
                        //         textColor: ThemeConstants.whitecolor,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ),
                        //   // child: CustomAutoSizeTextMontserrat(
                        //   //   text: "ADD",
                        //   //   fontSize: 16,
                        //   //   fontWeight: FontWeight.bold,
                        //   // ),
                        // ),
                      ],
                    ),

                    if (true) ...[
                      if (controller.meetingWith.value !=
                          'University Meetings') ...[
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: CustomAutoSizeTextMontserrat(
                              text: "Name of the Person",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        ///current
                        ///
                        ///
                        CustomMultiDownSingleAllUser(
                            model: controller.bankVendorPersonNameDropDownList,
                            initialSelectedValue: '',
                            // inititalSelectedList: ,
                            callbackFunctionSingle: (val) async {
                              controller.participantID.value = val;
                              await controller.fetchParticipantData();
                              var contains = false;

                              for (var i = 0;
                                  i < controller.listOfParticipants.length;
                                  i++) {
                                contains = false;
                                if (controller.listOfParticipants[i].id ==
                                    controller.participantData.id) {
                                  contains = true;
                                }
                              }

                              if (contains) {
                                getToast('Already added');
                                // showDialog(
                                //     context: context,
                                //     builder: (_) => AlertDialog(
                                //           content: Container(
                                //               child: Text('Already added')),
                                //         ));
                              } else if (controllers.participantData.id == 0) {
                                // showDialog(
                                //     context: context,
                                //     builder: (_) => AlertDialog(
                                //           content: Container(
                                //               child: Text(
                                //                   'Please add a representative')),
                                //         ));

                                getToast('Kindly add a representative');
                              } else {
                                controller.listOfParticipants
                                    .add(controllers.participantData);
                                controller.update();
                                getToast('Participant updated');
                                // showDialog(
                                //     context: context,
                                //     builder: (_) => AlertDialog(
                                //           shape: RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(20)),
                                //           content: Container(
                                //             child: Column(
                                //                 mainAxisSize: MainAxisSize.min,
                                //                 children: [
                                //                   Text(
                                //                       'Participant Added Successfully'),
                                //                   Icon(Icons.check_circle,
                                //                       size: 30,
                                //                       color: ThemeConstants
                                //                           .GreenColor)
                                //                 ]),
                                //           ),
                                //         ));
                              }

                              // controller.selectedBranch.value = val;
                              // controller.update();
                            },
                            callbackFunctionMulti: (List<AllUserModel> val) {
                              print(val);
                              // controller.selectedUsersList.value = val;
                              // controller.update();
                            },
                            enableMultiSelect: false),
//current
                        // Container(
                        //   padding:
                        //       EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                        //   decoration: BoxDecoration(
                        //       border: Border.all(
                        //           color: ThemeConstants.bluecolor, width: 1),
                        //       color: ThemeConstants.lightVioletColor,
                        //       borderRadius: BorderRadius.circular(500)),
                        //   width: double.infinity,
                        //   height: 40,
                        //   child: CustomAutoSizeTextMontserrat(
                        //     text: '${controller.participantData.personName}',
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8, top: 8),
                      //   child: Align(
                      //     alignment: AlignmentDirectional.topStart,
                      //     child: CustomAutoSizeTextMontserrat(
                      //       text: "Designation",
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),

                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //           color: ThemeConstants.bluecolor, width: 1),
                      //       color: ThemeConstants.lightVioletColor,
                      //       borderRadius: BorderRadius.circular(500)),
                      //   width: double.infinity,
                      //   height: 40,
                      //   child: CustomAutoSizeTextMontserrat(
                      //     text: '${controller.participantData.designation}',
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      // // CustomTextField(
                      // //   hint: '',
                      // //   controller: controller.designation.value,
                      // // ),

                      // // Padding(
                      // //   padding: const EdgeInsets.only(left: 15),
                      // //   child: Align(
                      // //     alignment: AlignmentDirectional.topStart,
                      // //     child: CustomAutoSizeTextMontserrat(
                      // //       text: "Add Representative",
                      // //       fontSize: 16,
                      // //       fontWeight: FontWeight.bold,
                      // //     ),
                      // //   ),
                      // // ),

                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8),
                      //   child: Align(
                      //     alignment: AlignmentDirectional.topStart,
                      //     child: CustomAutoSizeTextMontserrat(
                      //       text: "Email id",
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 0),
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             color: ThemeConstants.bluecolor, width: 1),
                      //         color: ThemeConstants.lightVioletColor,
                      //         borderRadius: BorderRadius.circular(500)),
                      //     width: double.infinity,
                      //     height: 40,
                      //     child: CustomAutoSizeTextMontserrat(
                      //       text: '${controller.participantData.email}',
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      // // CustomTextField(
                      // //   hint: '',
                      // //   controller: controller.designation.value,
                      // // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8),
                      //   child: Align(
                      //     alignment: AlignmentDirectional.topStart,
                      //     child: CustomAutoSizeTextMontserrat(
                      //       text: "Phone Number",
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 0),
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             color: ThemeConstants.bluecolor, width: 1),
                      //         color: ThemeConstants.lightVioletColor,
                      //         borderRadius: BorderRadius.circular(500)),
                      //     width: double.infinity,
                      //     height: 40,
                      //     child: CustomAutoSizeTextMontserrat(
                      //       text: controller.participantData.phone == null
                      //           ? ''
                      //           : '${controller.participantData.phone}',
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],

                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [...allParticipantsListFnc(controller)],
                      ),
                    ),

                    // CustomTextField(
                    //   hint: '',
                    //   controller: controller.designation.value,
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 0),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Wrap(
                    //       spacing: 10,
                    //       runSpacing: 10,
                    //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {
                    //             showDialog(
                    //                 context: context,
                    //                 builder: (_) =>
                    //                     DialogHora(controller: controller));
                    //             // controller.listOfParticipants
                    //             //     .add(controllers.participantData.value);
                    //             controller.update();
                    //           },
                    //           child: Container(
                    //             height: 38,
                    //             width: 170,
                    //             decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                     width: 1,
                    //                     color: ThemeConstants.orangeColor),
                    //                 color: Colors.transparent,
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(30.0))),
                    //             child: Center(
                    //               child: CustomAutoSizeTextMontserrat(
                    //                   text: "View Participants",
                    //                   textColor: ThemeConstants.orangeColor,
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w500),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: 15,
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             if (controller.listOfParticipants
                    //                 .contains(controller.participantData)) {
                    //               getToast('Already added');
                    //               // showDialog(
                    //               //     context: context,
                    //               //     builder: (_) => AlertDialog(
                    //               //           content: Container(
                    //               //               child: Text('Already added')),
                    //               //         ));
                    //             } else if (controllers.participantData.id == 0) {
                    //               // showDialog(
                    //               //     context: context,
                    //               //     builder: (_) => AlertDialog(
                    //               //           content: Container(
                    //               //               child: Text(
                    //               //                   'Please add a representative')),
                    //               //         ));

                    //               getToast('Please add a representative');
                    //             } else {
                    //               controller.listOfParticipants
                    //                   .add(controllers.participantData);
                    //               controller.update();
                    //               getToast('Participant Added Successfully');
                    //               // showDialog(
                    //               //     context: context,
                    //               //     builder: (_) => AlertDialog(
                    //               //           shape: RoundedRectangleBorder(
                    //               //               borderRadius:
                    //               //                   BorderRadius.circular(20)),
                    //               //           content: Container(
                    //               //             child: Column(
                    //               //                 mainAxisSize: MainAxisSize.min,
                    //               //                 children: [
                    //               //                   Text(
                    //               //                       'Participant Added Successfully'),
                    //               //                   Icon(Icons.check_circle,
                    //               //                       size: 30,
                    //               //                       color: ThemeConstants
                    //               //                           .GreenColor)
                    //               //                 ]),
                    //               //           ),
                    //               //         ));
                    //             }
                    //           },
                    //           child: Container(
                    //             height: 38,
                    //             width: MediaQuery.of(context).size.width * 0.55,
                    //             decoration: BoxDecoration(
                    //                 color: ThemeConstants.bluecolor,
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(30.0))),
                    //             child: Center(
                    //               child: CustomAutoSizeTextMontserrat(
                    //                   text: "Add Participants",
                    //                   textColor: ThemeConstants.whitecolor,
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w500),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    //
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: 200,
                    //   decoration: BoxDecoration(
                    //       color: ThemeConstants.whitecolor,
                    //       borderRadius: BorderRadius.circular(5),
                    //       border: Border.all(
                    //           width: 1, color: ThemeConstants.VioletColor)),
                    //   width: double.infinity,
                    //   child: ListView(
                    //     children: [
                    //       Wrap(
                    //           alignment: WrapAlignment.center,
                    //           spacing: 10,
                    //           children: [...controller.allParticipants(controllers)]),
                    //     ],
                    //   ),
                    // ),
                    // CustomMultiDownSingle(
                    //     enableMultiSelect: false,
                    //     callbackFunctionSingle: (val) {
                    //       controller.meetingWith.value = val;
                    //       controller.update();
                    //     },
                    //     model: controller.meetingWithList,
                    //     initialSelectedValue: '${controllers.meetingWith}'),

                    SizedBox(
                      height: 10,
                    )
                  ],

                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "SIEC Persons attending the meeting",
                        textColor: Color(0xff3088C6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "{ Triggers Notification } ",
                        textColor: ThemeConstants.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Select target audience type",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    height: 130,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.selectTargetAudienceType.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.selectedTargetAudience.value =
                                    controller.selectTargetAudienceType[index];

                                // controller.preFilledUsers.clear();
                                // if (val.toString().toLowerCase() == 'branch based') {
                                //   await controller.getBranchData();
                                //   controller.update();
                                // }
                                controller.groupNames.value = '';
                                controller.preFilledUsers = [];
                                if (controller.selectedTargetAudience.value ==
                                    'Branch Based') {
                                  controller.selectedBranchForUserList =
                                      controller.branchListwithFlag[0].id!;
                                  controller.branchSelected(
                                      controller.branchListwithFlag[0].id!);
                                  // controller
                                  //     .branchSelected(controller.branchList[0]);
                                }
                                if (controller.selectedTargetAudience.value ==
                                    'All User') {
                                  controller.preFilledUsers =
                                      Get.find<BaseController>()
                                          .allSiecMembersList;
                                }
                                controller.update();
                                // controller.selectMeetingBranch.value =
                                //     controller.branchListwithFlag[index].id!;
                                // controller.update();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: 140,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.indigoAccent.withOpacity(0.3),
                                      spreadRadius: -0.2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                  color: controller.selectedTargetAudience ==
                                          controller
                                              .selectTargetAudienceType[index]
                                      ? Color(0x803088C6)
                                      : ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(15),
                                  // border: Border.all(
                                  //     width: 1,
                                  //     color: ThemeConstants.bluecolor)
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 50,
                                          height: 50,
                                          child:
                                              // Icon(
                                              //   icons[index],
                                              //   size: 45,
                                              //   color: controller.selectedTargetAudience ==
                                              //       controller
                                              //           .selectTargetAudienceType[index]? Colors.white:Colors.black,
                                              // )

                                              Image.asset(
                                            icons[index], scale: 15,
                                            // color: controller.selectedTargetAudience ==
                                            //     controller
                                            //         .selectTargetAudienceType[index]? Colors.white:Colors.black,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${controller.selectTargetAudienceType[index]}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: controller
                                                        .selectedTargetAudience ==
                                                    controller
                                                            .selectTargetAudienceType[
                                                        index]
                                                ? Colors.white
                                                : Colors.black),
                                      )
                                    ]),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 0, bottom: 8),
                  //   child: Align(
                  //     alignment: AlignmentDirectional.topStart,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: "Select target Audience Type",
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //       mandatory: true,
                  //     ),
                  //   ),
                  // ),

                  // CustomMultiDownSingle(
                  //     field: Container(
                  //       height: 22,
                  //       child: CustomTextField(
                  //         forDropDown: false,
                  //         backgroundCOlour: Colors.transparent,
                  //         hint: '',
                  //         readOrEdit: true,
                  //         controller: TextEditingController(),
                  //         validator: controller.selectedTargetAudience.value == ''
                  //             ? Validator.plzSelectOne
                  //             : null,
                  //       ),
                  //     ),
                  //     callbackFunctionSingle: (val) async {
                  //       print(val);
                  //       controller.selectedTargetAudience.value = val;

                  //       // controller.preFilledUsers.clear();
                  //       // if (val.toString().toLowerCase() == 'branch based') {
                  //       //   await controller.getBranchData();
                  //       //   controller.update();
                  //       // }
                  //       controller.groupNames.value = '';
                  //       controller.preFilledUsers = [];
                  //       if (controller.selectedTargetAudience.value ==
                  //           'Branch Based') {
                  //         controller.branchSelected(controller.branchList[0]);
                  //       }
                  //       if (controller.selectedTargetAudience.value == 'All User') {
                  //         controller.preFilledUsers =
                  //             Get.find<BaseController>().allSiecMembersList;
                  //       }
                  //       controller.update();

                  //       // print(controller.selectedTargetAudience.value);
                  //     },
                  //     enableMultiSelect: false,
                  //     model: controller.selectTargetAudienceType,
                  //     initialSelectedValue:
                  //         '${controller.selectedTargetAudience.value}'),

                  if (controller.selectedTargetAudience.value ==
                      'Group Wise') ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Select Group",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CustomMultiDownSingle(
                        field: Container(
                          height: 22,
                          child: CustomTextField(
                            readOrEdit: true,
                            forDropDown: false,
                            backgroundCOlour: Colors.transparent,
                            hint: '',
                            controller: TextEditingController(),
                            validator: controller.groupNames.value == ''
                                ? Validator.plzSelectOne
                                : null,
                          ),
                        ),
                        callbackFunctionSingle: (val) async {
                          // print(val + "sdddd");
                          controller.groupNames.value = val;
                          await controller.showList(val);
                          controller.update();
                        },
                        enableMultiSelect: false,
                        model: controller.groupNamesAudienceType.value,
                        initialSelectedValue: ''),
                  ],

                  if (controller.selectedTargetAudience.value ==
                      'Branch Based') ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Select Branch",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height: 130,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.branchListwithFlag.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  controller.branchSelected(
                                      controller.branchListwithFlag[index].id!);
                                  // controller.selectMeetingBranch.value =
                                  //     controller.branchListwithFlag[index].id!;
                                  // controller.update();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  width: 140,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.indigoAccent
                                            .withOpacity(0.3),
                                        spreadRadius: -0.2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    color:
                                        controller.selectedBranchForUserList ==
                                                controller
                                                    .branchListwithFlag[index]
                                                    .id
                                            ? Color(0x803088C6)
                                            : ThemeConstants.whitecolor,
                                    borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(
                                    //     width: 1,
                                    //     color: ThemeConstants.bluecolor)
                                  ),
                                  // decoration: BoxDecoration(
                                  //     color: controller
                                  //                 .selectedBranchForUserList ==
                                  //             controller
                                  //                 .branchListwithFlag[index].id
                                  //         ? ThemeConstants.lightblueColor2
                                  //         : ThemeConstants.whitecolor,
                                  //     borderRadius: BorderRadius.circular(15),
                                  //     border: Border.all(
                                  //         width: 1,
                                  //         color: ThemeConstants.bluecolor)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: CachedNetworkImage(
                                            imageUrl: controller
                                                .branchListwithFlag[index]
                                                .imageLink!,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${controller.branchListwithFlag[index].name}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: controller
                                                        .selectedBranchForUserList ==
                                                    controller
                                                        .branchListwithFlag[
                                                            index]
                                                        .id
                                                ? Colors.white
                                                : ThemeConstants.blackcolor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ]),
                                ),
                              )),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 0),
                    //   child: Align(
                    //     alignment: AlignmentDirectional.topStart,
                    //     child: CustomAutoSizeTextMontserrat(
                    //       text: "Select Branch",
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    // CustomMultiDownSingleAllUser(
                    //   field: Container(
                    //     height: 22,
                    //     child: CustomTextField(
                    //       forDropDown: false,
                    //       backgroundCOlour: Colors.transparent,
                    //       hint: '',
                    //       controller: TextEditingController(),
                    //       validator: controller.selectedBranch.value == ''
                    //           ? Validator.plzSelectOne
                    //           : null,
                    //     ),
                    //   ),
                    //   enableMultiSelect: false,
                    //   model: controller.branchList,

                    //   initialSelectedValue: 'Siec Branch',
                    //   callbackFunctionSingle: (AllUserModel val) async {
                    //     await controller.branchSelected(val);
                    //   },
                    //   // callbackFunctionSingle: (AllUserModel val) {
                    //   //   print('$val ddd');
                    //   //   controller.selectMeetingBranch.value = val;
                    //   // },
                    // ),

                    // CustomMultiDownSingle(
                    //     callbackFunctionSingle: (val) async {
                    //       await controller.branchSelected(val);
                    //       controller.update();
                    //     },
                    //     enableMultiSelect: false,
                    //     model: controller.branchList.value,
                    //     initialSelectedValue: ''),
                  ],

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Select User",
                        mandatory: true,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  CustomMultiDownSingleAllUser(
                      model: Get.find<BaseController>().allSiecMembersList,
                      initialSelectedValue: '',
                      inititalSelectedList: controller.preFilledUsers,
                      field: Container(
                        height: 22,
                        child: CustomTextField(
                          forDropDown: false,
                          backgroundCOlour: Colors.transparent,
                          readOrEdit: true,
                          hint: '',
                          controller: TextEditingController(),
                          validator: controller.selectedUsersList.length == 0
                              ? Validator.plzSelectOne
                              : null,
                        ),
                      ),

                      // callbackFunctionSingle: (val) {
                      //   // controller.selectedBranch.value = val;
                      //   // controller.update();
                      // },
                      callbackFunctionMulti: (List<AllUserModel> val) {
                        print(val);
                        controller.selectedUsersList = val;
                        controller.update();
                      },
                      enableMultiSelect: true),

                  // CustomMultiDownSingle(
                  //     model: Get.find<DashBoardController>().listBro,
                  //     initialSelectedValue: '',
                  //     inititalSelectedList: ['Nancy Gupta', 'Admin', 'Sharmila'],
                  //     // callbackFunctionSingle: (val) {
                  //     //   // controller.selectedBranch.value = val;
                  //     //   // controller.update();
                  //     // },
                  //     callbackFunctionMulti: (val) {
                  //       print(val);
                  //       controller.selectedUsersList.value = val;
                  //       // controller.update();
                  //     },
                  //     enableMultiSelect: true),

                  // Container(
                  //   height: 45,
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   child: CustomTextField(
                  //     hint: '',
                  //     controller: controller.dateController.value,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15),
                  //   child: Align(
                  //     alignment: AlignmentDirectional.topStart,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: "Group Names",
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 45,
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   child: CustomTextField(
                  //     hint: '',
                  //     controller: controller.dateController.value,
                  //   ),
                  // ),

                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Meeting Coordinator",
                        mandatory: true,
                        fontSize: 14,
                        textColor: Color(0xff3088C6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CustomMultiDownSingleAllUser(
                      field: Container(
                        height: 22,
                        child: CustomTextField(
                          forDropDown: false,
                          backgroundCOlour: Colors.transparent,
                          readOrEdit: true,
                          hint: '',
                          controller: TextEditingController(),
                          validator:
                              controller.selectedCoordinatorList.length == 0
                                  ? Validator.plzSelectOne
                                  : null,
                        ),
                      ),
                      model: Get.find<BaseController>().allSiecMembersList,
                      initialSelectedValue: '',

                      // callbackFunctionSingle: (val) {
                      //   // controller.selectedBranch.value = val;
                      //   // controller.update();
                      // },
                      callbackFunctionMulti: (List<AllUserModel> val) {
                        print(val);
                        controller.selectedCoordinatorList.value = val;
                        controller.update();
                      },
                      enableMultiSelect: true),
                  // CustomMultiDownSingle(
                  //     model: controller.groupNamesAudienceType,
                  //     initialSelectedValue: '',
                  //     // inititalSelectedList: ['Nancy Gupta', 'Admin', 'Sharmila'],
                  //     // callbackFunctionSingle: (val) {
                  //     //   // controller.selectedBranch.value = val;
                  //     //   // controller.update();
                  //     // },
                  //     callbackFunctionMulti: (val) {
                  //       print(val);
                  //       controller.selectedCoordinatorList.value = val;
                  //       // controller.update();
                  //     },
                  //     enableMultiSelect: true),

                  // CustomMultiDownSingle(
                  //     enableMultiSelect: true,
                  //     callbackFunctionSingle: (val) {
                  //       controller.update();
                  //     },
                  //     model: controller.groupNamesAudienceType,
                  //     initialSelectedValue: ''),
                  // const SizedBox(
                  //   height: 25,
                  // ),

                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.key.currentState!.validate()) {
                        print(controller.externalMeeting);
                        if (controller.externalMeeting == false) {
                          controller.createNewMeeting(context);
                        } else {
                          controller.createExternalNewMeeting(context);
                        }
                        controller.key.currentState!.save();
                      } else {
                        getToast('${SnackBarConstants.requiredFields}');
                        //we can use this custom dialog too for showing the requiredFields or any warning message or error message{below}
                        // getDailog(context, SnackBarConstants.requiredFields ?? '');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: ThemeConstants.backgroundGradient,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: -0.2,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: CustomAutoSizeTextMontserrat(
                            text: "Create Meeting",
                            textColor: ThemeConstants.whitecolor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  )
                ])),
      )
    ];
  }

  // List<Widget> getExternalMeeting(
  addRepresentative(
      BuildContext context, CreateNewMeetingController2 controller) {
    return showAnimatedDialog(
        duration: Duration(milliseconds: 350),
        animationType: DialogTransitionType.slideFromBottomFade,
        context: context,
        builder: (_) {
          print(controller.addRepresentaitveType.value);
          return SafeArea(
              child: Stack(
            children: [
              Center(child: AddRepresentativeWidget(controller: controller)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                      // Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ThemeConstants.bluecolor,
                          borderRadius: BorderRadius.circular(200)),
                      child: Icon(
                        Icons.close_rounded,
                        color: ThemeConstants.whitecolor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
        });
  }

  //Updated here on 30th May 2024(aditya)

  addInstitute(BuildContext context, CreateNewMeetingController2 controller) {
    return showAnimatedDialog(
        duration: Duration(milliseconds: 350),
        animationType: DialogTransitionType.slideFromBottomFade,
        context: context,
        builder: (_) {
          return SafeArea(
              child: Stack(
            children: [
              Center(
                  child: AddInstituteWidget(
                addInstituteController: controller,
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ThemeConstants.bluecolor,
                          borderRadius: BorderRadius.circular(200)),
                      child: Icon(
                        Icons.close_rounded,
                        color: ThemeConstants.whitecolor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
        });
  }

// AddInstituteWidget(addInstituteController: controller,),
  List<Widget> allParticipantsListFnc(CreateNewMeetingController2 controller) {
    List<Widget> data = [];
    for (var i = 0; i < controller.listOfParticipants.length; i++) {
      data.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.indigoAccent.withOpacity(0.3),
              spreadRadius: -0.2,
              blurRadius: 5,
              offset: const Offset(0, 4),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1, color: ThemeConstants.VioletColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeTextMontserrat(
                    text: '${controller.listOfParticipants[i].personName}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Suitcase.svg',
                        width: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].designation}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].email}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].phone}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ]),
            Container(
              height: 60,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    controller.listOfParticipants.removeAt(i);
                    controller.update();
                    // setState(() {});
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ThemeConstants.lightRed),
                    child: Icon(
                      Icons.delete,
                      color: ThemeConstants.red,
                      size: 25,
                    ),
                  )),
            )
          ],
        ),
      ));
    }

    return data;
  }
}

//this widget will be used as for name of the partner or institute..
//also getting location will be implemented
class LocationBasedWidget extends StatefulWidget {
  final CreateNewMeetingController2 controller;

  const LocationBasedWidget({super.key, required this.controller});

  @override
  State<LocationBasedWidget> createState() => _LocationBasedWidgetState();
}

class _LocationBasedWidgetState extends State<LocationBasedWidget> {
  late FieldActivityBloc bloc;

  // late LocationData location;

  @override
  void initState() {
    bloc = FieldActivityBloc(context.read<FieldActivityRepo>());
    bloc.getAllStatesCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CustomAutoSizeTextMontserrat(
                      text: "Search Partner",
                      textColor: ThemeConstants.bluecolor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Institute State",
                      mandatory: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomMultiDownSingle(
                  model: bloc.stateNames,
                  initialSelectedValue: 'Select State',
                  enableMultiSelect: false,
                  callbackFunctionSingle: (Value) async {
                    setState(() {
                      bloc.selectedStateName = Value;
                      bloc.stateId = bloc.allStatesData.first
                          .data?[bloc.stateNames.indexOf(Value)].id;
                    });
                    await bloc.getAllCities(bloc.stateId);
                    await bloc.getAllAffiliationName(bloc.stateId);
                    print(
                        " this is id and state name- ${bloc.stateId}, ${bloc.selectedStateName}");
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 5,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Institute City",
                      mandatory: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: bloc.loadingCities,
                  builder: (BuildContext context, bool loading, __) {
                    return ValueListenableBuilder(
                      valueListenable: bloc.citiesData,
                      builder: (BuildContext context, CityModel model, __) {
                        return CustomMultiDownSingle(
                          model: bloc.cityNames,
                          initialSelectedValue: 'Select City',
                          enableMultiSelect: false,
                          callbackFunctionSingle: (Value) {
                            setState(() {
                              bloc.selectedCityName = Value;
                              bloc.cityId = bloc.allCitiesData.first
                                  .data1?[bloc.cityNames.indexOf(Value)].id;
                            });
                          },
                          callbackFunctionMulti: (Value) {},
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Institute Affiliation",
                      mandatory: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: bloc.loadingAffiliationName,
                  builder: (BuildContext context, bool loading, __) {
                    return ValueListenableBuilder(
                      valueListenable: bloc.AffiliationNameData,
                      builder: (BuildContext context, AllAffiliationModel model,
                          __) {
                        return CustomMultiDownSingle(
                          model: bloc.AffiliationNames,
                          initialSelectedValue: 'Select Affiliation',
                          enableMultiSelect: false,
                          callbackFunctionSingle: (Value) async {
                            setState(() {
                              bloc.selectedAffiliationName = Value;
                              bloc.affiliationId = bloc
                                  .allAffiliationNameData
                                  .first
                                  .data3?[bloc.AffiliationNames.indexOf(Value)]
                                  .id;
                            });
                          },
                          callbackFunctionMulti: (Value) {},
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "PinCode",
                      mandatory: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomTextField(
                    keybord: TextInputType.number,
                    validator: Validator.notEmpty,
                    hint: 'Enter PinCode',
                    controller: widget.controller.pinCode1.value),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await bloc.searchUniversityNames(int.parse("${widget.controller.pinCode1.value.text}"));
                    context.pop();
                   setState(() {
                     print('this is ${bloc.universityNames}');
                     print('this is controller update ${widget.controller.instituteUniversityNames}');
                   });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: ThemeConstants.backgroundGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: -0.2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: CustomAutoSizeTextMontserrat(
                          text: "Search",
                          textColor: ThemeConstants.whitecolor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class ExistingRepresentativeModal extends StatefulWidget {
  CreateNewMeetingController2 controller2;

  ExistingRepresentativeModal({super.key, required this.controller2});

  @override
  State<ExistingRepresentativeModal> createState() =>
      _ExistingRepresentativeModalState();
}

class _ExistingRepresentativeModalState
    extends State<ExistingRepresentativeModal> {
  @override
  Widget build(BuildContext context) {
    return CustomProfileDialogue(
        title: 'd',
        tap: (val) async {
          // if (key2.currentState!.validate()) {
          //   print(val);

          //   await controller.addANewRepresentative();
          //   context.pop();
          //   // Get.back();
          //   Get.defaultDialog(
          //       content: Container(
          //     child: Text('Representative Added'),
          //   ));
          // }
        },
        child: Container(
            alignment: Alignment.center,
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       width: 180,
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 0),
                //         child: Align(
                //           alignment: AlignmentDirectional.topStart,
                //           child: CustomAutoSizeTextMontserrat(
                //             text: "Participants Details",
                //             fontSize: 20,
                //             textColor: ThemeConstants.bluecolor,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         context.pop();
                //         // Get.back();
                //       },
                //       child: Container(
                //         margin: EdgeInsets.only(top: 10),
                //         width: 25,
                //         height: 25,
                //         alignment: Alignment.centerRight,
                //         child: CircleAvatar(
                //           radius: 25,
                //           backgroundColor: ThemeConstants.bluecolor,
                //           child: Icon(
                //             Icons.close,
                //             color: ThemeConstants.whitecolor,
                //             size: 20,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  height: 412,
                  child: ListView(
                    children: [
                      Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          children: [
                            ...allParticipants(widget.controller2, setState)
                          ]),
                    ],
                  ),
                ),
              ],
            )));
  }

  List<Widget> allParticipants(
      CreateNewMeetingController2 controller, StateSetter setstate) {
    List<Widget> data = [];
    for (var i = 0; i < controller.listOfParticipantData.length; i++) {
      data.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ThemeConstants.VioletColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeTextMontserrat(
                    text: '${controller.listOfParticipantData[i].name}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Suitcase.svg',
                        width: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // CustomAutoSizeTextMontserrat(
                      //   text: '${controller.listOfParticipants[i].designation}',
                      //   fontSize: 8,
                      //   fontWeight: FontWeight.w500,
                      //   textColor: ThemeConstants.TextColor,
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // CustomAutoSizeTextMontserrat(
                      //   text: '${controller.listOfParticipants[i].email}',
                      //   fontSize: 8,
                      //   fontWeight: FontWeight.w500,
                      //   textColor: ThemeConstants.TextColor,
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // CustomAutoSizeTextMontserrat(
                      //   text: '${controller.listOfParticipants[i].phone}',
                      //   fontSize: 8,
                      //   fontWeight: FontWeight.w500,
                      //   textColor: ThemeConstants.TextColor,
                      // ),
                    ],
                  ),
                ]),
            Container(
              height: 60,
              alignment: Alignment.center,
              child: Radio(
                onChanged: (val) {
                  print(val);
                  controller.participantID.value = val!;
                  setState(() {});
                  // controller.fetchParticipantData();
                  // controller.listOfParticipants.removeAt(i);
                  controller.update();
                },
                groupValue: controller.participantID.value,
                value: controller.listOfParticipantData[i],
              ),
            )
          ],
        ),
      ));
    }
    return data;
  }
}
