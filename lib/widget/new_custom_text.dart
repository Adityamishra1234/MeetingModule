import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:meeting_module2/utils/theme.dart';

class ContainerError<T> extends FormField<T> {
  ContainerError({
    required super.builder,
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
  });

  Super() {
    this.key;

    this.validator;

    this.initialValue;

    this.autovalidateMode;

    this.onSaved;

    this.enabled;

    this.restorationId;

    return Center(
        child: Text(
      "MyWidget",
      style: TextStyle(color: ThemeConstants.GreenColor),
    ));
  }

  //  @override

  // FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}
