import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int current = 0;

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
            (state) => Container(
              decoration: BoxDecoration(
                  gradient: ThemeConstants.backgroundGradient),
              padding: EdgeInsets.only(
                top: 35,
              ),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child:Text(
                            "View Notes",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                fontSize: 22,
                                color: ThemeConstants.paleYellow,
                                fontWeight: FontWeight.w600,
                              )
                            ),
                          )
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(height: 55,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.notesType.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    current = index;
                                    controller.selectedDropDown = controller.notesType[current].toString();
                                    controller.showThisNotesList(context);
                                    controller.update();
                                    // controller.showThisNotesList(context);
                                    //
                                    // controller.update();
                                  });
                                  // if(current == 0 ){
                                  //   setState(() {
                                  //         controller.selectedDropDown =controller.notesType[current].toString();
                                  //
                                  //         controller.showThisNotesList(context);
                                  //
                                  //         controller.update();
                                  //   });
                                  // }
                                  // else if(current == 1 ){
                                  //   setState(() {
                                  //     controller.selectedDropDown =controller.notesType[current].toString();
                                  //
                                  //     controller.showThisNotesList(context);
                                  //
                                  //     controller.update();
                                  //   });
                                  // }
                                  // else if(current == 2 ){
                                  //   setState(() {
                                  //     controller.selectedDropDown =controller.notesType[current].toString();
                                  //
                                  //     controller.showThisNotesList(context);
                                  //
                                  //     controller.update();
                                  //   });
                                  // }
                                },
                                child: AnimatedContainer(
                                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  height: 55,
                                  decoration: BoxDecoration(
                                    // gradient: current == index ? ThemeConstants.backgroundGradient : LinearGradient(colors: [
                                    //   Colors.white,
                                    //   Colors.white
                                    // ]),
                                      border:  current  == index ? Border.all(color: Colors.transparent):Border.all(color: Colors.black12),
                                      color: current == index? ThemeConstants.whitecolor: Color(0x50FFFFFF),
                                      borderRadius: current == index ? BorderRadius.all(Radius.circular(10)):BorderRadius.all(Radius.circular(5),)
                                  ),
                                  duration: Duration(milliseconds: 200),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 10, bottom: 10),
                                    child: Center(
                                      child: Text("${controller.notesType[index]}", style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: current == index? Colors.black : Colors.white,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        )
                        // DropdownButton2(
                        //   iconStyleData: IconStyleData(
                        //       iconEnabledColor:
                        //           ThemeConstants.whitecolor),
                        //   underline: Container(),
                        //   buttonStyleData: ButtonStyleData(
                        //       elevation: 5,
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //           color: Colors.transparent,
                        //           borderRadius: BorderRadius.circular(15),
                        //           border: Border.all(
                        //               width: 1,
                        //               color: ThemeConstants.whitecolor))),
                        //   dropdownStyleData:
                        //       DropdownStyleData(elevation: 3),
                        //   hint: Text(
                        //     '${controller.selectedDropDown}',
                        //     style: GoogleFonts.aBeeZee(
                        //       textStyle: TextStyle(
                        //         fontSize: 14,
                        //         color: ThemeConstants.whitecolor,
                        //       ),
                        //     )
                        //   ),
                        //
                        //   items: controller.notesType
                        //       .map((item) => DropdownMenuItem<String>(
                        //             value: item,
                        //             child: Text(
                        //               item,
                        //               style:GoogleFonts.aBeeZee(
                        //                 textStyle:  const TextStyle(
                        //                   fontSize: 14,
                        //                 ),
                        //               )
                        //             ),
                        //           ))
                        //       .toList(),
                        //   // value: controller.selectedDropDown == null
                        //   //     ?
                        //   //     : controller.selectedFilter.value,
                        //   onChanged: (value) {
                        //     // controller.frfr(value);
                        //
                        //     controller.selectedDropDown =
                        //         value.toString();
                        //
                        //     controller.showThisNotesList(context);
                        //
                        //     controller.update();
                        //
                        //     // controller.showSpecificMeeting(value);
                        //   },
                        //   // buttonHeight: 40,
                        //   // buttonWidth: 140,
                        //   // itemHeight: 40,
                        //   // itemWidth: 140,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: -8.2,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            )],
                          color: ThemeConstants.whitecolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [...controller.toshow],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onLoading: getLoading(context)));
  }
}
