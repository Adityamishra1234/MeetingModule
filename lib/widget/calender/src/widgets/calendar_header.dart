// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

import '../customization/header_style.dart';
import '../shared/utils.dart' show CalendarFormat, DayBuilder;
import 'custom_icon_button.dart';
import 'format_button.dart';

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;
  final VoidCallback onTapCustomButtonInHeader;
  const CalendarHeader({
    Key? key,
    this.locale,
    required this.onTapCustomButtonInHeader,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
  }) : super(key: key);

  ffff() {
    print('d');
  }

  @override
  Widget build(BuildContext context) {
    final text = headerStyle.titleTextFormatter?.call(focusedMonth, locale) ??
        DateFormat.yMMMM(locale).format(focusedMonth);

    return Container(
      decoration: headerStyle.decoration,
      margin: headerStyle.headerMargin,
      padding: headerStyle.headerPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (headerStyle.leftChevronVisible)
            CustomIconButton(
              icon: headerStyle.leftChevronIcon,
              onTap: onLeftChevronTap,
              margin: headerStyle.leftChevronMargin,
              padding: headerStyle.leftChevronPadding,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Icon(
              Icons.calendar_month,
              color: ThemeConstants.whitecolor,
            ),
          ),
          Expanded(
            child: headerTitleBuilder?.call(context, focusedMonth) ??
                GestureDetector(
                  onTap: onHeaderTap,
                  onLongPress: onHeaderLongPress,
                  child: Text(
                    text,
                    style: headerStyle.titleTextStyle,
                    textAlign: headerStyle.titleCentered
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                ),
          ),
          // InkWell(
          //   onTap: onTapCustomButtonInHeader,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(2200),
          //         border:
          //             Border.all(width: 1, color: ThemeConstants.whitecolor)),
          //     child: Row(children: [
          //       CircleAvatar(
          //         radius: 9,
          //         backgroundColor: ThemeConstants.whitecolor,
          //         child: Icon(
          //           Icons.add,
          //           size: 16,
          //           color: ThemeConstants.bluecolor,
          //         ),
          //       ),
          //       SizedBox(
          //         width: 8,
          //       ),
          //       CustomAutoSizeTextMontserrat(
          //         text: '',
          //         fontSize: 10,
          //         textColor: ThemeConstants.whitecolor,
          //       )
          //     ]),
          //   ),
          // ),
          if (headerStyle.formatButtonVisible &&
              availableCalendarFormats.length > 1)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FormatButton(
                onTap: onFormatButtonTap,
                availableCalendarFormats: availableCalendarFormats,
                calendarFormat: calendarFormat,
                decoration: headerStyle.formatButtonDecoration,
                padding: headerStyle.formatButtonPadding,
                textStyle: headerStyle.formatButtonTextStyle,
                showsNextFormat: headerStyle.formatButtonShowsNext,
              ),
            ),
          if (headerStyle.rightChevronVisible)
            CustomIconButton(
              icon: headerStyle.rightChevronIcon,
              onTap: onRightChevronTap,
              margin: headerStyle.rightChevronMargin,
              padding: headerStyle.rightChevronPadding,
            ),
        ],
      ),
    );
  }
}
