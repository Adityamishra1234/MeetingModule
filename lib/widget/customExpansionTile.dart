import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/ui/screens/assign_to_view.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomExpansionPlanList extends StatefulWidget {
  String? titel;
  String? text;
  List<FindNotesModel>? dataList;
  CustomExpansionPlanList({Key? key, this.titel, this.text, this.dataList})
      : super(key: key);

  @override
  State<CustomExpansionPlanList> createState() =>
      _CustomExpansionPlanListState();
}

class _CustomExpansionPlanListState extends State<CustomExpansionPlanList> {
  String? title;
  String? text;
  @override
  void initState() {
    title = widget.titel;
    text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width > 600;
    double width = MediaQuery.of(context).size.width;
    if (displayMobileLayout == true) {
      width = MediaQuery.of(context).size.width - 240;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ConfigurableExpansionTile(
        header: Flexible(
          child: SizedBox(
            // width: width - 10,
            height: 40,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomAutoSizeTextMontserrat(
                    text: title,
                    textColor: ThemeConstants.bluecolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        childrenBody: Column(
          children: [
            ...dataList(),

            // Check Box
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: HtmlWidget(
            //     text!,
            //     textStyle: GoogleFonts.montserrat(
            //       fontWeight: FontWeight.w500,
            //       color: ThemeConstants.TextColor,
            //       fontSize: 14.0,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  dataList() {
    List<Widget> data = [];
    for (var i = 0; i < widget.dataList!.length; i++) {
      data.add(Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: HtmlWidget("${widget.dataList![i].note}"),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "${widget.dataList![i].createdBy}",
                  textColor: ThemeConstants.TextColor,
                  fontSize: 12,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(AssignToView(), arguments: widget.dataList![i]);
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

    return data;
  }
}
