import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/allStatesModel.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_dialog_box.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:provider/provider.dart';

import '../../Bloc_Repo_Field_Activity/Bloc/field_activity_bloc.dart';
import '../../Bloc_Repo_Field_Activity/Repo/get_field_activity_repo.dart';

class AddInstituteWidget extends StatefulWidget {
  final CreateNewMeetingController2 addInstituteController;

  AddInstituteWidget({super.key, required this.addInstituteController});

  @override
  State<AddInstituteWidget> createState() => _AddInstituteWidgetState();
}

class _AddInstituteWidgetState extends State<AddInstituteWidget> {
  GlobalKey<FormState> key3 = GlobalKey<FormState>();
  late FieldActivityBloc bloc;

  @override
  void initState() {
    bloc = FieldActivityBloc(context.read<FieldActivityRepo>());
    bloc.getAllStatesCities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bloc.loadingStatesAndCities,
      builder: (BuildContext context, bool loading,__) {
        if (loading) {
          return Center(
              child: CircularProgressIndicator(
                color: ThemeConstants.bluecolor,
              ));
        }

        return CustomProfileDialogue(
            tap: (val) async {
              if (key3.currentState!.validate()) {
                bool success = await bloc.postAdd(
                    int.parse("${bloc.stateId}"),
                    int.parse("${bloc.cityId}"),
                    1, //here based on school college value will be going 3 for school
                    widget.addInstituteController.typeOfInstituteSubCategory.value,
                    int.parse("${bloc.affiliationId}"),
                    widget.addInstituteController.nameOfInstitute.value.text,
                    widget.addInstituteController.addressOfInstitute.value.text,
                    widget.addInstituteController.landMarkOfInstitute.value.text,
                    widget.addInstituteController.pinCode.value.text,
                context);
                if(success){
                  getToast('Institute updated');
                  context.pop();
                }
                else {getToast('Institute Not updated');}
              }
            },
            child: Container(
              child: Form(
                key: key3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                          print(" this is id and state name- ${bloc.stateId}, ${bloc.selectedStateName}");
                        },
                      ),
                      // CustomMultiDownSingleAllUser(
                      //     enableMultiSelect: false,
                      //     callbackFunctionSingle: (val) {
                      //       print(val);
                      //       widget.addInstituteController.addInstituteType.value = val;
                      //       widget.addInstituteController.update();
                      //       // controller.inItGetRepresentative();
                      //     },
                      //     model:[],
                      //     initialSelectedValue: ''
                      //
                      //   // inititalSelectedList: controller.preFilledUsers.value,
                      //
                      // ),
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
                      // CustomMultiDownSingleAllUser(
                      //     model: widget.addInstituteController.allCountriesList,
                      //     initialSelectedValue: '',
                      //     // inititalSelectedList: controller.preFilledUsers.value,
                      //     callbackFunctionSingle: (val) async {
                      //       widget.addInstituteController.selectedCountry = val;
                      //       widget.addInstituteController.update();
                      //       await widget.addInstituteController
                      //           .getUniversities(widget.addInstituteController.selectedCountry.id!);
                      //       widget.addInstituteController.update();
                      //     },
                      //     callbackFunctionMulti: (AllUserModel val) {
                      //       print(val);
                      //     },
                      //     enableMultiSelect: false),
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
                                    bloc.cityId = bloc
                                        .allCitiesData
                                        .first
                                        .data1?[bloc.cityNames.indexOf(Value)]
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
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 5,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Institute Type",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // CustomMultiDownSingle(
                      //   enableMultiSelect: false,
                      //   callbackFunctionSingle: (val) {
                      //     widget.addInstituteController.typeOfInstitute.value =
                      //         val;
                      //     print(val);
                      //   },
                      //   model: widget.addInstituteController.instituteType,
                      //   initialSelectedValue: 'Select Type',
                      // ),
                      SizedBox(
                          height: 60,
                          child: ListView.builder(
                            itemCount: widget.addInstituteController.instituteType.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.addInstituteController.typeOfInstitute.value = widget.addInstituteController.instituteType[index];
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
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
                                    color:widget.addInstituteController.typeOfInstitute.value ==
                                        widget.addInstituteController.instituteType[index] ? Color(
                                        0x803088C6) : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${widget.addInstituteController.instituteType[index]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: widget.addInstituteController.typeOfInstitute.value ==
                                            widget.addInstituteController.instituteType[index] ? Colors
                                            .white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Institute Sub Category",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomMultiDownSingle(
                        enableMultiSelect: false,
                        callbackFunctionSingle: (val) {
                          widget.addInstituteController
                              .typeOfInstituteSubCategory.value = val;
                          print(val);
                        },
                        model:
                        widget.addInstituteController.instituteSubCategory,
                        initialSelectedValue: 'Select Category',
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
                            builder: (BuildContext context,
                                AllAffiliationModel model, __) {
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
                                        .data3?[bloc.AffiliationNames.indexOf(
                                        Value)]
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
                            text: "Institute Name",
                            mandatory: true,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomTextField(
                          validator: Validator.notEmpty,
                          hint: 'Enter Institute Name',
                          controller: widget
                              .addInstituteController.nameOfInstitute.value),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Institute Address",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomTextField(
                          validator: Validator.notEmpty,
                          hint: 'Enter Full Address',
                          keybord: TextInputType.text,
                          controller: widget
                              .addInstituteController.addressOfInstitute.value),
                      SizedBox(
                        height: 14,
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
                          controller:
                          widget.addInstituteController.pinCode.value),

                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 10),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomAutoSizeTextMontserrat(
                            text: "Landmark (Optional)",
                            mandatory: false,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomTextField(
                          hint: 'Enter Landmark',
                          controller: widget.addInstituteController
                              .landMarkOfInstitute.value),
                    ]),
              ),
            ),

            title: 'Add Institute');
      },
    );
  }
}
