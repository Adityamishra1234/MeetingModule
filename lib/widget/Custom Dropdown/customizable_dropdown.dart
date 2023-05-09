import 'package:flutter/material.dart';
import 'package:meeting_module2/widget/Custom%20Dropdown/expand_section.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomizableDropdown extends StatefulWidget {
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
  final Widget placeholder;

  /// must set the dropdown item list
  final List<dynamic> itemList;

  /// receive the selected item call back function
  /// The list of items the user can select
  final Function(String item) onSelectedItem;

  /// Give padding of the dropdown container
  final EdgeInsetsGeometry? dropDownPadding;

  /// set the dropdown container colour
  final Color? colorDropDown;

  /// set the dropdown container constraint
  final BoxConstraints? constraintsDropDown;

  /// Give the margin of the dropdown container
  final EdgeInsetsGeometry? marginDropDown;

  /// Here we go the dropdown StateFull Widget
  const CustomizableDropdown({
    Key? key,
    required this.itemList,
    required this.onSelectedItem,
    required this.placeholder,
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
  }) : super(key: key);

  @override
  _CustomizableDropdownState createState() => _CustomizableDropdownState();
}

class _CustomizableDropdownState extends State<CustomizableDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// If the [Placeholder] is null
  /// this will displayed the selected index of List
  String? selectedItem;

  /// this variable is used to open/close the drop down is user touch dropdown container or list of dropdown selected
  /// Default is false to it hide the dropdown
  bool isExpanded = false;

  //Finally its removing the animated Controller
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    /// We need to hold these animations as state because of their
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  // padding: widget.dropDownPadding,
                  color: widget.colorDropDown,
                  constraints: widget.constraintsDropDown,
                  margin: widget.marginDropDown,
                  height: widget.height ?? 30,
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
                          child:
                              // if selectedItem has null placeholder string available
                              selectedItem == null
                                  ? widget.placeholder
                                  : CustomAutoSizeTextMontserrat(
                                      text: selectedItem ?? "",
                                      // textAlign: widget.titleAlign,
                                      // style: widget.titleStyle
                                    ),
                        ),
                      )),
                      // if it has icon dropdown available on right side icon and with rotate animated
                      widget.icon != null
                          ? SizedBox(
                              width: 30,
                              child: RotationTransition(
                                  turns: Tween(begin: 0.0, end: 0.5)
                                      .animate(_controller),
                                  child: widget.icon),
                            )
                          : Container()
                    ],
                  ),
                ),
                //Expanded Dropdown list
                expandDropDownMethod(),
              ]),
            ),
          )),
        ]),
      ],
    );
  }

  /// Widget that builds the dropdown overlay.
  ///
  /// This Widget is responsible to create the dropdown
  /// overlay menu every time is open.
  /// This menu has a [onSelectedItem] callback, used to
  /// pass upwards the on value changed event, from his children
  /// to the [CustomDropDown].
  ExpandedSection expandDropDownMethod() => ExpandedSection(
      height: 50,
      expand: isExpanded,
      child: SizedBox(
        height: widget.maxHeight,
        child: Scrollbar(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(2),
            itemCount: widget.itemList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    print("aman");
                    widget.onSelectedItem(widget.itemList[index]);
                    isExpanded
                        ? _controller.reverse(from: 0.5)
                        : _controller.forward(from: 0.25);
                    isExpanded = !isExpanded;
                    selectedItem = widget.itemList[index];
                    setState(() {
                      /// it detects the user click and display the new selected value
                      // of onChanged callback here.
                    });
                  },
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.red,
                      color: widget.listColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: widget.listTitle ??
                            Text(widget.itemList.elementAt(index),
                                textAlign: TextAlign.start,
                                style: widget.titleStyle),
                      )));
            },
            // separatorBuilder: (BuildContext context, int index) =>
            //     widget.seperator ??
            //     const Divider(
            //       thickness: 0.5,
            //     ),
          ),
        ),
      ));
}
