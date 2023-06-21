import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_module2/models/dashboardNotesModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/assign_to_view.dart';
import 'package:meeting_module2/ui/screens/assign_to_view_dasboard.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardNotesController extends GetxController with StateMixin {
  ApiServices apiServices = ApiServices();

  int id = 0;

  @override
  void onInit() async {
    // TODO: implement onInit

    await meetingId();
    await getNotesData();

    change(null, status: RxStatus.success());
    super.onInit();
  }

  List<Widget> notes = [];

  List<Map<String, List<Widget>>> viewNotes = [];

  List<Widget> toshow = [];
  var notesType = ['All Notes'];
  String selectedDropDown = 'All Notes';

  List<Widget> beta = [];

  List<FindNotesModel> data = [];
  getNotesData() async {
    var res = await apiServices.findNoteByUser(id);
    List<dynamic> data2 = res;

    data = await List<FindNotesModel>.from(
        data2.map((e) => FindNotesModel.fromJson(e)));

    print(data);

    for (var i = 0; i < data.length; i++) {
      String note2 = await getNoteTypefromId(data[i].noteType!);
      notesType.add(note2);
    }

    notesType = notesType.toSet().toList();

    for (var i = 0; i < notesType.length; i++) {
      // String note2 = await getNoteTypefromId(data[i].noteType!);
      // notesType.add(note2);
      viewNotes.add({notesType[i]: []});
    }

    print(notesType);

    // for (var i = 0; i < viewNotes.length; i++) {
    //   beta.addAll(viewNotes[i].entries.first.value);
    //   // documentlist.addAll(list[i].entries.first.value);
    // }
    showThisNotesList();
  }

  showThisNotesList() {
    beta = [];
    for (var i = 0; i < data.length; i++) {
      if (selectedDropDown == 'All Notes') {
        beta.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          // width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: HtmlWidget(
                    "${data[i].note}",
                    textStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: ThemeConstants.TextColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "${data[i].createdAt}",
                    textColor: ThemeConstants.TextColor,
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(AssignToView(), arguments: widget.dataList![i]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            color: ThemeConstants.bluecolor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0))),
                        child: InkWell(
                          onTap: () {
                            Get.to(AssignToView2(), arguments: data[i]);
                          },
                          child: Center(
                            child: CustomAutoSizeTextMontserrat(
                              text: "Assign to",
                              textColor: ThemeConstants.whitecolor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      } else if (selectedDropDown == getNoteTypefromId(data[i].noteType!)) {
        beta.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          // width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: HtmlWidget(
                    "${data[i].note}",
                    textStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: ThemeConstants.TextColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "${data[i].createdAt}",
                    textColor: ThemeConstants.TextColor,
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(AssignToView(), arguments: widget.dataList![i]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            color: ThemeConstants.bluecolor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0))),
                        child: Center(
                          child: CustomAutoSizeTextMontserrat(
                            text: "Assign to",
                            textColor: ThemeConstants.whitecolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      }
    }

    toshow = [];
    toshow = beta;
    update();
  }

  meetingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = await prefs.getInt('id')!;
    print(id);
  }
}
