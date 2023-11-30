import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/widget/custom_dialog_box.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';

class AddRepresentativeWidget extends StatelessWidget {
  CreateNewMeetingController2 controller;
  AddRepresentativeWidget({super.key, required this.controller});
  GlobalKey<FormState> key2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => CustomProfileDialogue(
        tap: (val) async {
          if (key2.currentState!.validate()) {
            await controller.addANewRepresentative();
            // await controller.getUniversities(val);
            // controller.selectedUniversity = controller.allUniversityList[0];
            // await controller.getRepresentativesByUniversity();
            // await controller.fetchParticipantData();
            await controller.getRepresentativeDropDownData();

            getToast('Representative updated');
            context.pop();
          }
        },
        child: Container(
          child: Form(
            key: key2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Representative Type",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomMultiDownSingle(
                      enableMultiSelect: false,
                      callbackFunctionSingle: (val) {
                        print(val);
                        controller.addRepresentaitveType.value = val;
                        controller.update();
                        // controller.inItGetRepresentative();
                      },
                      model: ['University', 'Vendor', 'Bank'],
                      initialSelectedValue:
                          controller.addRepresentaitveType.value

                      // inititalSelectedList: controller.preFilledUsers.value,

                      ),

                  SizedBox(
                    height: 10,
                  ),
                  // Wrap(
                  //   children: [
                  //     CustomButton(
                  //         backgroundColor: ThemeConstants.bluecolor,
                  //         text: 'University',
                  //         onPressed: () {
                  //           controller.addRepresentaitveType.value = 'University';
                  //           controller.update();
                  //         }),
                  //     CustomButton(
                  //         backgroundColor: ThemeConstants.bluecolor,
                  //         text: 'Vendor',
                  //         onPressed: () {
                  //           controller.addRepresentaitveType.value = 'Vendor';
                  //           controller.update();
                  //         }),
                  //     CustomButton(
                  //         backgroundColor: ThemeConstants.bluecolor,
                  //         text: 'Bank',
                  //         onPressed: () {
                  //           controller.addRepresentaitveType.value = 'Bank';
                  //           controller.update();
                  //         }),
                  //   ],
                  // ),
                  if (controller.addRepresentaitveType.value ==
                      'University') ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        bottom: 5,
                      ),
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
                        // inititalSelectedList: controller.preFilledUsers.value,
                        callbackFunctionSingle: (val) async {
                          controller.selectedCountry = val;
                          controller.update();
                          await controller
                              .getUniversities(controller.selectedCountry.id!);
                          controller.update();
                        },
                        callbackFunctionMulti: (AllUserModel val) {
                          print(val);
                        },
                        enableMultiSelect: false),
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
                        callbackFunctionSingle: (AllUserModel val) async {
                          print(val);

                          controller.selectedUniversityName.value = val;
                        },
                        callbackFunctionMulti: (AllUserModel val) {
                          print(val);
                        },
                        enableMultiSelect: false),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  if (controller.addRepresentaitveType.value == 'Vendor') ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 5),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Name of Vendor",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CustomTextField(
                        validator: Validator.notEmpty,
                        hint: 'Vendor name',
                        controller: controller.nameOfTheVendor.value),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  if (controller.addRepresentaitveType.value == 'Bank') ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 5),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Name of Bank",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CustomTextField(
                        validator: Validator.notEmpty,
                        hint: 'Name of Bank',
                        controller: controller.nameOfTheBank.value),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of Person",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomTextField(
                      validator: Validator.notEmpty,
                      hint: 'Person Name',
                      controller: controller.nameOfThePerson.value),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Email",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  CustomTextField(
                      validator: Validator.email,
                      hint: 'Enter Your Email',
                      controller: controller.email.value),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Designation",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomTextField(
                      validator: Validator.notEmpty,
                      hint: 'Enter Your Designation',
                      controller: controller.designation.value),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Phone Number",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomTextField(
                      validator: Validator.phone,
                      hint: 'Enter Your Phone Number',
                      keybord: TextInputType.number,
                      controller: controller.RePphoneNumber.value),
                ]),
          ),
        ),
        title: 'Add Representative'));
  }
}
