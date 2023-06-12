// import 'package:flutter/material.dart';

// // class CustomDropDownWithValidator extends FormField {
// //   CustomDropDownWithValidator({required super.builder});
// // }
// class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
//   @override
//   void didChange(T? value) {
//     super.didChange(value);
//     final DropdownButtonFormField<T> dropdownButtonFormField =
//         widget as DropdownButtonFormField<T>;
//     assert(dropdownButtonFormField.onChanged != null);
//     dropdownButtonFormField.onChanged!(value);
//   }

//   @override
//   void didUpdateWidget(DropdownButtonFormField<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.initialValue != widget.initialValue) {
//       setValue(widget.initialValue);
//     }
//   }
// }

// class CustomDropDownWithValidator<T> extends FormField<T> {
//   /// Creates a [DropdownButton] widget that is a [FormField], wrapped in an
//   /// [InputDecorator].
//   ///
//   /// For a description of the `onSaved`, `validator`, or `autovalidateMode`
//   /// parameters, see [FormField]. For the rest (other than [decoration]), see
//   /// [DropdownButton].
//   ///
//   /// The `items`, `elevation`, `iconSize`, `isDense`, `isExpanded`,
//   /// `autofocus`, and `decoration`  parameters must not be null.
//   CustomDropDownWithValidator({
//     super.key,
//     required List<DropdownMenuItem<T>>? items,
//     DropdownButtonBuilder? selectedItemBuilder,
//     T? value,
//     Widget? hint,
//     Widget? disabledHint,
//     required this.onChanged,
//     VoidCallback? onTap,
//     int elevation = 8,
//     TextStyle? style,
//     Widget? icon,
//     Color? iconDisabledColor,
//     Color? iconEnabledColor,
//     double iconSize = 24.0,
//     bool isDense = true,
//     bool isExpanded = false,
//     double? itemHeight,
//     Color? focusColor,
//     FocusNode? focusNode,
//     bool autofocus = false,
//     Color? dropdownColor,
//     InputDecoration? decoration,
//     super.onSaved,
//     super.validator,
//     AutovalidateMode? autovalidateMode,
//     double? menuMaxHeight,
//     bool? enableFeedback,
//     AlignmentGeometry alignment = AlignmentDirectional.centerStart,
//     BorderRadius? borderRadius,
//     // When adding new arguments, consider adding similar arguments to
//     // DropdownButton.
//   }) : super(
//           initialValue: value,
//           autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
//           builder: (FormFieldState<T> field) {
//             final _DropdownButtonFormFieldState<T> state =
//                 field as _DropdownButtonFormFieldState<T>;
//             final InputDecoration decorationArg =
//                 decoration ?? InputDecoration(focusColor: focusColor);
//             final InputDecoration effectiveDecoration =
//                 decorationArg.applyDefaults(
//               Theme.of(field.context).inputDecorationTheme,
//             );

//             final bool showSelectedItem = items != null &&
//                 items
//                     .where(
//                         (DropdownMenuItem<T> item) => item.value == state.value)
//                     .isNotEmpty;
//             bool isHintOrDisabledHintAvailable() {
//               final bool isDropdownDisabled =
//                   onChanged == null || (items == null || items.isEmpty);
//               if (isDropdownDisabled) {
//                 return hint != null || disabledHint != null;
//               } else {
//                 return hint != null;
//               }
//             }

//             final bool isEmpty =
//                 !showSelectedItem && !isHintOrDisabledHintAvailable();

//             // An unfocusable Focus widget so that this widget can detect if its
//             // descendants have focus or not.
//             return Focus(
//               canRequestFocus: false,
//               skipTraversal: true,
//               child: Builder(builder: (BuildContext context) {
//                 return Container(child: Text('ddd'));
//               }),
//             );
//           },
//         );

//   /// {@macro flutter.material.dropdownButton.onChanged}
//   final ValueChanged<T?>? onChanged;

//   /// The decoration to show around the dropdown button form field.
//   ///
//   /// By default, draws a horizontal line under the dropdown button field but
//   /// can be configured to show an icon, label, hint text, and error text.
//   ///
//   /// If not specified, an [InputDecorator] with the `focusColor` set to the
//   /// supplied `focusColor` (if any) will be used.
//   final InputDecoration decoration;

//   @override
//   FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
// }
