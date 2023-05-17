import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/customizable_dropdown.dart';

// import 'package:studentpanel/utils/theme.dart';
// import 'package:studentpanel/widgets/Custom%20Dropdown/customizable_dropdown.dart';
// import 'package:studentpanel/widgets/customautosizetextmontserrat.dart';

class CustomMultiDownSingle extends StatelessWidget {
  bool? choosefieldtype;
  List model;
  bool? enableMultiSelect;
  String initialSelectedValue;
  final Function? callbackFunctionSingle;
  final Function? callbackFunctionMulti;
  CustomMultiDownSingle(
      {Key? key,
      required this.model,
      this.callbackFunctionSingle,
      this.callbackFunctionMulti,
      this.choosefieldtype,
      required this.initialSelectedValue,
      this.enableMultiSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List selectedItems = [];

    return choosefieldtype == true
        ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
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
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CustomizableDropdown(
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
                print(sele);
              },

              onMultiSelectedItem: (item) {
                print(item);
                // selectedItems = item;

                // callbackFunctionMulti!(item);
              },
              initalValue: initialSelectedValue,

              // placeholder: Align(
              //   alignment: AlignmentDirectional.centerStart,
              //   child: Text('${selectedItems.join('')}'),
              //   // child: CustomAutoSizeTextMontserrat(
              //   //     text: initialSelectedValue))),
              // )
            ));
  }
}
