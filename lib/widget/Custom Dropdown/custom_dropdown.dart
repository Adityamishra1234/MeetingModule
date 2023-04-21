import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/Custom%20Dropdown/customizable_dropdown.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomDropDown extends StatelessWidget {
  bool? editEnable;
  List model;
  String? initialSelectedValue;
  final Function callbackFunction;
  CustomDropDown({
    Key? key,
    required this.model,
    required this.callbackFunction,
    required this.editEnable,
    required this.initialSelectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return editEnable == false
        ? Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: ThemeConstants.bluecolor),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomAutoSizeTextMontserrat(
                text: "Test",
                textColor: ThemeConstants.TextColor,
              ),
            ),
          )
        : CustomizableDropdown(
            maxHeight: 100,
            height: 45,
            icon: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
            ),
            titleAlign: TextAlign.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            itemList: model,
            onSelectedItem: (sele) {
              callbackFunction(sele);
            },
            placeholder: Align(
                alignment: AlignmentDirectional.centerStart,
                child:
                    CustomAutoSizeTextMontserrat(text: initialSelectedValue)));
  }
}
