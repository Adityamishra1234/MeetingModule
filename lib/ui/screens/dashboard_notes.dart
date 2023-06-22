import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/dashboard_notes_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class DashboardNotesView extends StatefulWidget {
  DashboardNotesView({super.key});

  @override
  State<DashboardNotesView> createState() => _DashboardNotesViewState();
}

class _DashboardNotesViewState extends State<DashboardNotesView> {
  var controller = Get.put(DashboardNotesController());

  @override
  void dispose() {
    controller.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx(
            (state) => SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 8, right: 8),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, bottom: 5),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "View Notes",
                                  fontSize: 35,
                                  textColor: ThemeConstants.bluecolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              DropdownButton2(
                                underline: Container(),
                                buttonStyleData: ButtonStyleData(
                                    elevation: 0,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: ThemeConstants.blackcolor))),
                                dropdownStyleData:
                                    DropdownStyleData(elevation: 1),
                                hint: Text(
                                  '${controller.selectedDropDown}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
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

                                  controller.showThisNotesList();

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
                          height: 20,
                        ),
                        Expanded(
                          child: ListView(
                            children: [...controller.toshow],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            onLoading: getLoading(context)));
  }
}
