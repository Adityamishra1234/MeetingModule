import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/Custom%20Dropdown/customizable_dropdown.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomDropDownSingle extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return choosefieldtype == true
        ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: ThemeConstants.lightblueColor,
                  // border: Border.all(color: ThemeConstants.bluecolor),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomAutoSizeTextMontserrat(
                  textColor: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  text: initialSelectedValue,
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CustomizableDropdown(
                maxHeight: 150,
                height: 50,
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
                titleAlign: TextAlign.center,
                decoration: BoxDecoration(
                  color: ThemeConstants.lightblueColor,
                  // border: Border.all(color: ThemeConstants.bluecolor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                itemList: model,
                onSelectedItem: (sele) {
                  callbackFunction(sele);
                },
                placeholder: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomAutoSizeTextMontserrat(
                        text: initialSelectedValue))),
          );
  }
}
