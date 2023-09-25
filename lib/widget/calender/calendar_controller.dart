import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:meeting_module2/widget/calender/src/shared/utils.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

Map<DateTime, List<Event>> map1 = {
  DateTime.now(): [Event('ddd'), Event('ddd')],
  DateTime.now(): [Event('ddd'), Event('ddd')]
};

class CalendarController with ChangeNotifier {
  void datesHaveMeetings() {
    notifyListeners();
  }

  bool thisMonthHaveEvent = false;
  bool loading = false;

  tableCalendarSwipeEvent(month, year) async {
    print('object');
    loading = true;
    notifyListeners();
    thisMonthHaveEvent = !thisMonthHaveEvent;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));

    loading = false;

    notifyListeners();
  }

  // Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0
  /// Example event class.

  /// Example events.
  ///
  /// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
  final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(map1);

// var test = new Map<DateTime, List<String>>();

  // final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
  //     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
  //     value: (item) => List.generate(
  //         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  //   ..addAll({
  //     kToday: [
  //       Event('Today\'s Event 1'),
  //       Event('Today\'s Event 2'),
  //     ],
  //   });

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  // final kToday = DateTime.now();
  // final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
  // final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
}
