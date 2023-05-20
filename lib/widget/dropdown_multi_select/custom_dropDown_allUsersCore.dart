import 'package:flutter/material.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/expand_section.dart';

// import 'package:studentpanel/widgets/Custom%20Dropdown/expand_section.dart';
// import 'package:studentpanel/widgets/customautosizetextmontserrat.dart';

class CustomizableDropdownAllUser extends StatefulWidget {
  /// Color of the dropdown list
  final Color? listColor;

  /// Create the seperator of each dropdown item. If you pass Null it will take defalt Divider
  final Widget? seperator;

  /// Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
  final double? maxHeight;

  /// set dropdown list each title widget
  final Widget? listTitle;

  /// set dropdown list each title alight
  final TextAlign? titleAlign;

  /// Style the dropdown title
  final TextStyle? titleStyle;

  /// set the dropdown icon
  final Widget? icon;

  /// set the dropdown crossAxisAlignment
  final CrossAxisAlignment? crossAxisAlignment;

  /// set the dropdown mainAxisAlignment
  final MainAxisAlignment? mainAxisAlignment;

  /// decorate the dropdown
  final Decoration? decoration;

  /// set the dropdown height
  final double? height;

  /// set the dropdown width
  final double? width;

  /// A placeholder widget that is displayed by the dropdown
  final Widget? placeholder;

  /// must set the dropdown item list
  List<AllUserModel>? itemList;

  /// receive the selected item call back function
  /// The list of items the user can select
  final Function? onSingleSelectedItem;

  final Function? onMultiSelectedItem;

  final String initalValue;

  /// Give padding of the dropdown container
  final EdgeInsetsGeometry? dropDownPadding;

  /// set the dropdown container colour
  final Color? colorDropDown;

  /// set the dropdown container constraint
  final BoxConstraints? constraintsDropDown;

  /// Give the margin of the dropdown container
  final EdgeInsetsGeometry? marginDropDown;

  // Selected Dropdown
  final String? selectedItem;

//Bool for Multi
  final bool multiSelectEnable;

  List<AllUserModel>? initialSelectedList;

  /// Here we go the dropdown StateFull Widget
  CustomizableDropdownAllUser(
      {Key? key,
      required this.initalValue,
      this.selectedItem,
      this.itemList,
      this.onSingleSelectedItem,
      this.placeholder,
      this.maxHeight,
      this.height,
      this.width,
      this.decoration,
      this.crossAxisAlignment,
      this.mainAxisAlignment,
      this.icon,
      this.listTitle,
      this.seperator,
      this.colorDropDown,
      this.constraintsDropDown,
      this.dropDownPadding,
      this.marginDropDown,
      this.listColor,
      this.titleAlign,
      this.titleStyle,
      this.onMultiSelectedItem,
      this.initialSelectedList,
      this.multiSelectEnable = false})
      : super(key: key);

  @override
  _CustomizableDropdownAllUserState createState() =>
      _CustomizableDropdownAllUserState();
}

class _CustomizableDropdownAllUserState
    extends State<CustomizableDropdownAllUser>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController scrollControler = ScrollController();

  /// If the [Placeholder] is null
  /// this will displayed the selected index of List
  String? selectedItem;

  /// this variable is used to open/close the drop down is user touch dropdown container or list of dropdown selected
  /// Default is false to it hide the dropdown
  bool isExpanded = false;

// Create list using for search
  List<AllUserModel> items = [];

  List<AllUserModel> selectedItemsList = [];

  late AllUserModel singleSelectedItem;

  // For Search field
  TextEditingController editingController = TextEditingController();

  bool isSelected = false;

  //Finally its removing the animated Controller
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    singleSelectedItem = widget.itemList![0];

    /// We need to hold these animations as state because of their
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    // filterSearchResults("");
    super.initState();
    items = widget.itemList!;
    if (widget.initialSelectedList != null) {
      widget.initialSelectedList!
          .forEach((element) => selectedItemsList.add(element));
      // selectedItemsList.addAll(widget.initialSelectedList.map((e) => e) );
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("didChangeDependencies");
    // filterSearchResults("");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CustomizableDropdownAllUser oldWidget) {
    // TODO: implement didUpdateWidget
    // if (oldWidget.initialSelectedList != widget.initialSelectedList) {
    //   widget.initialSelectedList = selectedItemsList;
    //   setState(() {});
    // }
    if (oldWidget.itemList != widget.itemList) {
      singleSelectedItem = widget.itemList![0];
    }
    print("didChangeDependencies  cccc");
    print(oldWidget.initialSelectedList == widget.initialSelectedList);
    if (widget.initialSelectedList != null) {
      if (oldWidget.initialSelectedList != widget.initialSelectedList) {
        selectedItemsList.clear();
        widget.initialSelectedList!
            .forEach((element) => selectedItemsList.add(element));

        setState(() {});
      }

      // selectedItemsList.addAll(widget.initialSelectedList.map((e) => e) );
    }
    // filterSearchResults(editingController.text);
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.selectedItem);
    selectedItem = widget.selectedItem;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded
                    ? _controller.reverse(from: 0.5)
                    : _controller.forward(from: 0.25);
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              // decoration: BoxDecoration(color: Colors.red),
              decoration: widget.decoration,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1, color: ThemeConstants.lightgreycolor)),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // padding: widget.dropDownPadding,
                  // color: widget.colorDropDown,

                  constraints: widget.constraintsDropDown,
                  margin: widget.marginDropDown,
                  // height: widget.height ?? 30,
                  width: widget.width ?? double.infinity,
                  child: Row(
                    mainAxisAlignment:
                        widget.mainAxisAlignment ?? MainAxisAlignment.center,
                    crossAxisAlignment:
                        widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: widget.multiSelectEnable
                                ? Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [...data()]
                                    //     ListView.separated(
                                    //   separatorBuilder: (context, index) {
                                    //     return SizedBox(
                                    //       width: 10,
                                    //     );
                                    //   },
                                    //   scrollDirection: Axis.horizontal,
                                    //   itemCount: selectedItemsList.length,
                                    //   itemBuilder: (context, index) {
                                    //     return Container(
                                    //         height: 10,
                                    //         alignment: Alignment.center,
                                    //         padding: EdgeInsets.symmetric(
                                    //             vertical: 5, horizontal: 7),
                                    //         decoration: BoxDecoration(
                                    //             color: ThemeConstants
                                    //                 .ultraLightgreyColor,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(20)),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.center,
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.center,
                                    //           children: [
                                    //             Text(
                                    //                 '${selectedItemsList[index]}'),
                                    //             SizedBox(
                                    //               width: 10,
                                    //             ),
                                    //             GestureDetector(
                                    //               onTap: () {
                                    //                 selectedItemsList.remove(
                                    //                     selectedItemsList[
                                    //                         index]);
                                    //                 setState(() {});
                                    //                 widget.onMultiSelectedItem!(
                                    //                     selectedItemsList);

                                    //                 ;
                                    //                 // print(
                                    //                 //     selectedItemsList);
                                    //               },
                                    //               child: CircleAvatar(
                                    //                   backgroundColor:
                                    //                       ThemeConstants
                                    //                           .bluelightgreycolor,
                                    //                   child: Icon(
                                    //                     Icons.close,
                                    //                     size: 17,
                                    //                   )),
                                    //             )
                                    //           ],
                                    //         ));
                                    //   },
                                    // )),

                                    )
                                : Text('${singleSelectedItem.name}')
                            // if selectedItem has null placeholder string available

                            // widget.placeholder

                            // selectedItem == null
                            //     ? widget.placeholder
                            //     : CustomAutoSizeTextMontserrat(
                            //         text: selectedItem ?? "",
                            //         // textAlign: widget.titleAlign,
                            //         // style: widget.titleStyle
                            //       ),
                            ),
                      )),
                      // if it has icon dropdown available on right side icon and with rotate animated
                      widget.icon != null
                          ? SizedBox(
                              width: 30,
                              child: RotationTransition(
                                  turns: Tween(begin: 1.25, end: 2.25)
                                      .animate(_controller),
                                  child: widget.icon),
                            )
                          : Container()
                    ],
                  ),
                ),
                //Expanded Dropdown list
                expandedSection()
              ]),
            ),
          )),
        ]),
      ],
    );
  }

  ExpandedSection expandedSection() => ExpandedSection(
      height: 50,
      expand: isExpanded,
      child: Container(
        child: SizedBox(
          height: 230,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value.toString());
                    },
                    controller: editingController,
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: ThemeConstants.lightgreycolor)),
                  constraints: BoxConstraints(maxHeight: 150),
                  child: Scrollbar(
                    isAlwaysShown: false,
                    thickness: 0,
                    controller: scrollControler,
                    child: ListView.builder(
                      controller: scrollControler,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(2),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              if (widget.multiSelectEnable == true) {
                                if (selectedItemsList.contains(items[index])) {
                                  selectedItemsList.remove(items[index]);
                                  widget
                                      .onMultiSelectedItem!(selectedItemsList);
                                  setState(() {
                                    // isSelected = false;
                                  });
                                  widget
                                      .onMultiSelectedItem!(selectedItemsList);
                                } else {
                                  selectedItemsList.add(items[index]);
                                  widget
                                      .onMultiSelectedItem!(selectedItemsList);
                                  setState(() {
                                    // isSelected = false;
                                  });
                                }
                                // print(selectedItemsList);
                              } else {
                                // widget.onSelectedItem(items[index]);
                                isExpanded
                                    ? _controller.reverse(from: 0.5)
                                    : _controller.forward(from: 0.25);
                                isExpanded = !isExpanded;

                                singleSelectedItem = items[index];

                                widget
                                    .onSingleSelectedItem!(singleSelectedItem);

                                // print(selectedItemsList);

                                setState(() {
                                  /// it detects the user click and display the new selected value
                                  // of onChanged callback here.
                                });
                              }
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.red,
                                color: widget.listColor,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text('${items[index].name}',
                                              textAlign: TextAlign.start,
                                              style: widget.titleStyle),
                                        ),
                                        if (widget.multiSelectEnable ==
                                            true) ...[
                                          selectedItemsList
                                                  .contains(items[index])
                                              ? Icon(Icons.check_rounded)
                                              : Icon(
                                                  Icons.check_rounded,
                                                  color: Color.fromARGB(
                                                      0, 247, 55, 55),
                                                )
                                        ] else ...[
                                          singleSelectedItem == items[index]
                                              ? Icon(Icons.check_rounded)
                                              : Icon(
                                                  Icons.check_rounded,
                                                  color: Color.fromARGB(
                                                      0, 247, 55, 55),
                                                )
                                        ],
                                      ],
                                      // widget.listTitle ??
                                      //     Text(items.elementAt(index),
                                      //         textAlign: TextAlign.start,
                                      //         style: widget.titleStyle),
                                    ))));
                      },
                      // separatorBuilder: (BuildContext context, int index) =>
                      //     widget.seperator ??
                      //     const Divider(
                      //       thickness: 0.5,
                      //     ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
  //Function
  void filterSearchResults(String query) {
    print(query);
    setState(() {
      items = widget.itemList!
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  List<Widget> data() {
    List<Widget> data = [];

    for (var i = 0; i < selectedItemsList.length; i++) {
      data.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 35,
              // constraints: ConstrainedBox(constraints: ),
              // height: 4,

              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              decoration: BoxDecoration(
                  color: ThemeConstants.ultraLightgreyColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${selectedItemsList[i].name}'),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedItemsList.remove(selectedItemsList[i]);
                      setState(() {});
                      widget.onMultiSelectedItem!(selectedItemsList);

                      ;
                      // print(
                      //     selectedItemsList);
                    },
                    child: CircleAvatar(
                        backgroundColor: ThemeConstants.bluelightgreycolor,
                        child: Icon(
                          Icons.close,
                          size: 17,
                        )),
                  )
                ],
              )),
          SizedBox(),
        ],
      ));
    }
    return data;
  }
}
