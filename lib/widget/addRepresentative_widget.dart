import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_dialog_box.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';

class AddRepresentativeWidget extends StatelessWidget {
  CreateNewMeetingController2 controller;
  AddRepresentativeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => CustomProfileDialogue(
        tap: (val) async {
          print(val);

          await controller.addANewRepresentative();
          Get.back();
          Get.defaultDialog(
              content: Container(
            child: Text('Representative Added'),
          ));
        },
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    CustomButton(
                        backgroundColor: ThemeConstants.bluecolor,
                        text: 'University',
                        onPressed: () {
                          controller.addRepresentaitveType.value = 'University';
                          controller.update();
                        }),
                    CustomButton(
                        backgroundColor: ThemeConstants.bluecolor,
                        text: 'Vendor',
                        onPressed: () {
                          controller.addRepresentaitveType.value = 'Vendor';
                          controller.update();
                        }),
                    CustomButton(
                        backgroundColor: ThemeConstants.bluecolor,
                        text: 'Bank',
                        onPressed: () {
                          controller.addRepresentaitveType.value = 'Bank';
                          controller.update();
                        }),
                  ],
                ),
                if (controller.addRepresentaitveType.value == 'University') ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Country",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "University Name",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                ],
                if (controller.addRepresentaitveType.value == 'Vendor') ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of Vendor",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomTextField(
                      hint: 'Vendor name',
                      controller: controller.nameOfTheVendor.value),
                ],
                if (controller.addRepresentaitveType.value == 'Bank') ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of Bank",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomTextField(
                      hint: 'Name of Bank',
                      controller: controller.nameOfTheBank.value),
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Name of Person",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                    hint: 'Person Name',
                    controller: controller.nameOfThePerson.value),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Email",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                    validator: Validator.email,
                    hint: 'hint',
                    controller: controller.email.value),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Designation",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                    hint: 'hint', controller: controller.designation.value),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Phone Number",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                    validator: Validator.phone,
                    hint: 'hint',
                    keybord: TextInputType.number,
                    controller: controller.RePphoneNumber.value),
              ]),
        ),
        title: 'Add Representative'));
  }
}
