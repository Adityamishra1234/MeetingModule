import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class ViewDocs extends StatelessWidget {
  const ViewDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                child: CustomAutoSizeTextMontserrat(
                    align: TextAlign.left,
                    textColor: ThemeConstants.bluecolor,
                    fontSize: 20,
                    text: 'View Doc Notes'),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: Get.find<AddMoreNotesController>()
                        .imageNotesList
                        .length,
                    itemBuilder: (context, index) {
                      FindNotesModel model = Get.find<AddMoreNotesController>()
                          .imageNotesList[index];
                      var name = Get.find<AddMoreNotesController>()
                          .nameFromid(model.createdBy);
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ThemeConstants.TextColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: CustomAutoSizeTextMontserrat(
                                        text: name,
                                        textColor: ThemeConstants.bluecolor,
                                      ),
                                    ),
                                    const Spacer(),
                                    // SizedBox(
                                    //     width: 55,
                                    //     child: FileDownload(url: model[i].viewlink!)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.find<AddMoreNotesController>()
                                            .getViewDocument(model.image_note!);
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    ThemeConstants.bluecolor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            size: 18,
                                            color: ThemeConstants.bluecolor,
                                          ),
                                          // child: CustomAutoSizeTextMontserrat(
                                          //   text: "View",
                                          //   fontSize: 10,
                                          //   fontWeight: FontWeight.w500,
                                          //   textColor: ThemeConstants.orangeColor,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
