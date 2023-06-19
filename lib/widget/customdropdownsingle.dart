import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomDropDownSingle extends StatefulWidget {
  bool? choosefieldtype;
  List model;
  String? initialSelectedValue;
  final Function callbackFunction;
  CustomDropDownSingle({
    Key? key,
    required this.model,
    required this.callbackFunction,
    required this.choosefieldtype,
    required this.initialSelectedValue,
  }) : super(key: key);

  @override
  _CustomDropDownSingleState createState() => _CustomDropDownSingleState();
}

class _CustomDropDownSingleState extends State<CustomDropDownSingle> {
  String? initialSelectedValue2;
  @override
  Widget build(BuildContext context) {
    bool match = false;
    if (widget.model.isNotEmpty) {
      for (var i = 0; i < widget.model.length; i++) {
        if (widget.initialSelectedValue == widget.model[i]) {
          match = true;
        }
      }
      if (match == false) {
        widget.initialSelectedValue = widget.model[0];
      }
    }

    try {
      final bool displayMobileLayout = MediaQuery.of(context).size.width > 600;
      return widget.choosefieldtype == false
          ? Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ThemeConstants.lightgreycolor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    menuMaxHeight: 200,
                    elevation: 0,
                    underline: const SizedBox(),
                    // Initial Value
                    value: widget.initialSelectedValue,
                    alignment: AlignmentDirectional.bottomEnd,
                    // Down Arrow Icon
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: ThemeConstants.blackcolor,
                    ),
                    iconEnabledColor: ThemeConstants.whitecolor,

                    // Array list of items
                    items: widget.model.toSet().toList().map((dynamic items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            //Todo
                            width: displayMobileLayout == true
                                ? MediaQuery.of(context).size.width - 300
                                : MediaQuery.of(context).size.width - 70,
                            child: CustomAutoSizeTextMontserrat(
                              text: items,
                              textColor: ThemeConstants.TextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    onChanged: (dynamic newValue) {
                      widget.initialSelectedValue = newValue!;
                      // initialSelectedValue2 = newValue;
                      widget.callbackFunction(newValue);
                      setState(() {});
                    },
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                maxLines: 1,
                textInputAction: TextInputAction.next,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: widget.initialSelectedValue,
                  filled: true,
                  fillColor: ThemeConstants.lightgreycolor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                style: ThemeConstants.montserrattextstyle2,
              ),
            );
    } catch (e) {
      return Container();
    }
  }
}
