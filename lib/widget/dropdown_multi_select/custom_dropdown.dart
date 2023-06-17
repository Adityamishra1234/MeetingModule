import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/customizable_dropdown.dart';

// import 'package:studentpanel/utils/theme.dart';
// import 'package:studentpanel/widgets/Custom%20Dropdown/customizable_dropdown.dart';
// import 'package:studentpanel/widgets/customautosizetextmontserrat.dart';

class CustomMultiDownSingle extends StatelessWidget {
  bool? choosefieldtype;
  List model;
  bool? enableMultiSelect;
  String? initialSelectedValue;
  List? inititalSelectedList;
  Function? callbackFunctionSingle;
  Function? callbackFunctionMulti;
  Widget? field;
  CustomMultiDownSingle(
      {Key? key,
      required this.model,
      this.callbackFunctionSingle,
      this.callbackFunctionMulti,
      this.choosefieldtype,
      required this.initialSelectedValue,
      this.inititalSelectedList,
      this.field,
      this.enableMultiSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List selectedItems = [];

    return choosefieldtype == true
        ? Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // color: ThemeConstants.lightblueColor,
                // border: Border.all(color: ThemeConstants.bluecolor),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              // child: CustomAutoSizeTextMontserrat(
              //   textColor: Colors.black,
              //   fontSize: 14,
              //   fontWeight: FontWeight.bold,
              //   text: initialSelectedValue,
              // ),
            ),
          )
        : CustomizableDropdown(
            field: field,
            // colorDropDown: Colors.black,
            selectedItem: initialSelectedValue,
            maxHeight: 150,
            height: 50,
            icon: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
            ),
            titleAlign: TextAlign.center,
            decoration: BoxDecoration(
              // color: ThemeConstants.lightblueColor,
              // border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            itemList: model,
            multiSelectEnable: enableMultiSelect ?? false,
            onSingleSelectedItem: (sele) {
              if (enableMultiSelect == false) {
                callbackFunctionSingle!(sele);
              }
            },

            onMultiSelectedItem: (item) {
              // print(item);
              // selectedItems = item;
              if (enableMultiSelect == true) {
                // print(item);
                callbackFunctionMulti!(item);
              }
            },
            initalValue: initialSelectedValue!,
            initialSelectedList: inititalSelectedList,

            // placeholder: Align(
            //   alignment: AlignmentDirectional.centerStart,
            //   child: Text('${selectedItems.join('')}'),
            //   // child: CustomAutoSizeTextMontserrat(
            //   //     text: initialSelectedValue))),
            // )
          );
  }
}
