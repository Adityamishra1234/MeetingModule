import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/dashboard_notes_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class DashboardNotesView extends StatefulWidget {
  static const routenamed = '/dashboardNotes';
  DashboardNotesView({super.key});

  @override
  State<DashboardNotesView> createState() => _DashboardNotesViewState();
}

class _DashboardNotesViewState extends State<DashboardNotesView> {
  var controller = Get.put(DashboardNotesController());

  @override
  void dispose() {
    controller.onDelete;

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    controller.doIntial(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx(
            (state) => SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: ThemeConstants.backgroundGradient),
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 5),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "View Notes",
                                  fontSize: 24,
                                  textColor: ThemeConstants.paleYellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton2(
                                iconStyleData: IconStyleData(
                                    iconEnabledColor:
                                        ThemeConstants.whitecolor),
                                underline: Container(),
                                buttonStyleData: ButtonStyleData(
                                    elevation: 0,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: ThemeConstants.whitecolor))),
                                dropdownStyleData:
                                    DropdownStyleData(elevation: 1),
                                hint: Text(
                                  '${controller.selectedDropDown}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ThemeConstants.whitecolor,
                                  ),
                                ),

                                items: controller.notesType
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                // value: controller.selectedDropDown == null
                                //     ?
                                //     : controller.selectedFilter.value,
                                onChanged: (value) {
                                  // controller.frfr(value);

                                  controller.selectedDropDown =
                                      value.toString();

                                  controller.showThisNotesList(context);

                                  controller.update();

                                  // controller.showSpecificMeeting(value);
                                },
                                // buttonHeight: 40,
                                // buttonWidth: 140,
                                // itemHeight: 40,
                                // itemWidth: 140,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: ThemeConstants.whitecolor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35))),
                            padding: const EdgeInsets.only(
                                top: 30, left: 25, right: 25),
                            child: ListView(
                              children: [...controller.toshow],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            onLoading: getLoading(context)));
  }
}
