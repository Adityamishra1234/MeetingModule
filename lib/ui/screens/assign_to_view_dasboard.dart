import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:meeting_module2/models/dashboardNotesModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/assignToController.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';

class AssignToView2 extends StatefulWidget {
  FindNotesModel argu;
  AssignToView2({super.key, required this.argu});

  @override
  State<AssignToView2> createState() => _AssignToView2State();
}

class _AssignToView2State extends State<AssignToView2> {
  TextEditingController controller = TextEditingController();

  var getController = Get.put(AssignToController());
  late FindNotesModel data;
  @override
  void initState() {
    // FindNotesModel argu = Get.arguments;
    data = widget.argu;
    getController.taskOwner = Get.find<BaseController>().allSiecMembersList[0];
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AssignToController>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getController.obx(
          (state) => Form(
            key: getController.key,
            child: Container(
              color: Colors.white,
              width: 350,
              // padding: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Assign Task",
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color:Color(0xff3088C6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CustomAutoSizeTextMontserrat(
                      text: "Specify Task Name",
                      mandatory: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomTextField(
                        validator: Validator.notEmpty,
                        hint: "Type of task",
                        controller: controller),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CustomAutoSizeTextMontserrat(
                      text: "Task Owner",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomMultiDownSingleAllUser(

                    // model: ['d', 'd'],
                      model:
                      Get.find<BaseController>().allSiecMembersList,
                      // callbackFunction: callback,
                      // callbackFunctionMulti: (val) {
                      //   print(val);
                      // },
                      callbackFunctionSingle: (val) {
                        getController.taskOwner =
                        Get.find<BaseController>()
                            .allSiecMembersList[0];
                        getController.update();
                      },
                      enableMultiSelect: false,
                      choosefieldtype: false,
                      initialSelectedValue: "1"),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CustomAutoSizeTextMontserrat(
                      text: "Select a deadline for a task",
                      mandatory: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      height: 45,
                      child: CustomTimerWidget(
                        callback: (value) {
                          print(value);
                          getController.deadLine = value;
                          getController.update();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Spacer(),

                      InkWell(
                        onTap: (){
                          if (getController.key.currentState!
                              .validate()) {
                            // print(getController.taskOwner.name);
                            getController.assign(
                                data, controller.text, context);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              gradient: ThemeConstants.backgroundGradient,
                              boxShadow: [
                                BoxShadow(

                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: -0.2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                )],
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                          child: Center(child: CustomAutoSizeTextMontserrat(text: "Add Task",textColor: Colors.white,align: TextAlign.center,)),
                        ),
                      ),
                      // SizedBox(
                      //   width: 150,
                      //   height: 50,
                      //   child: CustomButton(
                      //     backgroundColor: ThemeConstants.bluecolor,
                      //     text: "Add Task",
                      //     onPressed: () {
                      //       if (getController.key.currentState!
                      //           .validate()) {
                      //         // print(getController.taskOwner.name);
                      //         getController.assign(
                      //             data, controller.text, context);
                      //       }
                      //       // getController.key.currentState!.save();
                      //       // print(getController.taskOwner.name);
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          onLoading: getLoading(context)),
    );
  }
}


// Container(
//               color: Colors.white,
//               width: 350,
//               // padding: EdgeInsets.only(left: 15, top: 10, right: 15),
//               child: ListView(
//                 physics: BouncingScrollPhysics(),
//                 children: [
//                   Align(
//                     alignment: AlignmentDirectional.topStart,
//                     child: Text(
//                       "Assign Task",
//                       style: GoogleFonts.aBeeZee(
//                           textStyle: TextStyle(
//                             fontSize: 25,
//                             color:Color(0xff3088C6),
//                             fontWeight: FontWeight.w600,
//                           ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: CustomAutoSizeTextMontserrat(
//                       text: "Specify Task Name",
//                       mandatory: true,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: CustomTextField(
//                         validator: Validator.notEmpty,
//                         hint: "Type of task",
//                         controller: controller),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: CustomAutoSizeTextMontserrat(
//                       text: "Task Owner",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   CustomMultiDownSingleAllUser(
//
//                       // model: ['d', 'd'],
//                       model:
//                           Get.find<BaseController>().allSiecMembersList,
//                       // callbackFunction: callback,
//                       // callbackFunctionMulti: (val) {
//                       //   print(val);
//                       // },
//                       callbackFunctionSingle: (val) {
//                         getController.taskOwner =
//                             Get.find<BaseController>()
//                                 .allSiecMembersList[0];
//                         getController.update();
//                       },
//                       enableMultiSelect: false,
//                       choosefieldtype: false,
//                       initialSelectedValue: "1"),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: CustomAutoSizeTextMontserrat(
//                       text: "Select a deadline for a task",
//                       mandatory: true,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(),
//                     child: Container(
//                       height: 45,
//                       child: CustomTimerWidget(
//                         callback: (value) {
//                           print(value);
//                           getController.deadLine = value;
//                           getController.update();
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     children: [
//                       const Spacer(),
//
//                       InkWell(
//                         onTap: (){
//                           if (getController.key.currentState!
//                               .validate()) {
//                             // print(getController.taskOwner.name);
//                             getController.assign(
//                                 data, controller.text, context);
//                           }
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 120,
//                           decoration: BoxDecoration(
//                               gradient: ThemeConstants.backgroundGradient,
//                               boxShadow: [
//                                 BoxShadow(
//
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: -0.2,
//                                   blurRadius: 5,
//                                   offset: const Offset(0, 4),
//                                 )],
//                               borderRadius:
//                               const BorderRadius.all(Radius.circular(10.0))),
//                           child: Center(child: CustomAutoSizeTextMontserrat(text: "Add Task",textColor: Colors.white,align: TextAlign.center,)),
//                         ),
//                       ),
//                       // SizedBox(
//                       //   width: 150,
//                       //   height: 50,
//                       //   child: CustomButton(
//                       //     backgroundColor: ThemeConstants.bluecolor,
//                       //     text: "Add Task",
//                       //     onPressed: () {
//                       //       if (getController.key.currentState!
//                       //           .validate()) {
//                       //         // print(getController.taskOwner.name);
//                       //         getController.assign(
//                       //             data, controller.text, context);
//                       //       }
//                       //       // getController.key.currentState!.save();
//                       //       // print(getController.taskOwner.name);
//                       //     },
//                       //   ),
//                       // ),
//                       SizedBox(
//                         width: 5,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),