import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/placeholder.dart';

import 'package:meeting_module2/utils/theme.dart';

import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';

import 'package:meeting_module2/widget/dropdown_multi_select/customizable_dropdown.dart';
import 'package:meeting_module2/widget/new_custom_text.dart';

class TestForm extends StatelessWidget {
  TestForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  List<DropdownMenuItem<dynamic>> sampleList = [
    DropdownMenuItem(
      value: 1,
      child: Text('Option 1'),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text('Option 2'),
    ),
    DropdownMenuItem(
      value: 3,
      child: Text('Option 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey1,
        child: Column(
          children: [
            Spacer(),
            Center(
              child: ContainerError(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  print("object");

                  print(value);

                  return "test by amna";
                },
                builder: (FormFieldState<dynamic> field) {
                  // print(field.value);

                  field.setValue("dkafsd");

                  // print(field.value);

                  return Column(
                    children: [
                      CustomMultiDownSingle(
                        initialSelectedValue: 'test',
                        model: ["test", "dkafsd", "kdf", "wirh "],
                        callbackFunctionMulti: (value) {
                          field.setValue(value);
                        },
                      ),
                      if (field.errorText != null)
                        CustomAutoSizeTextMontserrat(
                          text: field.errorText,
                          textColor: ThemeConstants.red,
                        )
                    ],
                  );
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  if (_formKey1.currentState!.validate()) {
                    // Key is valid, perform further actions

                    _formKey1.currentState!.save();
                  }
                },
                icon: Icon(Icons.abc)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
