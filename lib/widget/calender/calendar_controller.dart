import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
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

class CalendarController extends GetxController with StateMixin {
  @override
  void onInit() async {
    var date = DateTime.now();
    await getMonthMeetingDates(
        Get.find<BaseController>().id, date.month, date.year);
    // TODO: implement onInit
    super.onInit();
  }

  ApiServices api = ApiServices();

  List<DateTime> meetingListData = [];

  final Map<int, DateTime> planets = HashMap();

  bool isEventDay = false;

  bool loading = false;

  DateTime? monthSelected = null;

  DateTime? selectedDayGlobal;
  DateTime? focusedDayGlobal = DateTime.now();

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDayGlobal, selectedDay)) {
      selectedDayGlobal = selectedDay;
      focusedDayGlobal = focusedDay;

      Get.find<DashBoardController>().getMeetingOfThatDate(selectedDay);

      update();
      // _focusedDay = focusedDay;
      // _rangeStart = null; // Important to clean those
      // _rangeEnd = null;
      // _rangeSelectionMode = RangeSelectionMode.toggledOff;

      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }

    update();
  }

  var counter = DateTime.now().month;

  void onPageChanged(DateTime focusedDay) {
    if (focusedDay.month > counter + 1 || focusedDay.month < counter - 1) {
      monthSelected = focusedDay;
      focusedDayGlobal = focusedDay;

      update();

      getMonthMeetingDates(
          Get.find<BaseController>().id, focusedDay.month, focusedDay.year);

      counter = focusedDay.month;
      var month = focusedDay.month;
      var year = focusedDay.year;
    } else {}
  }

  getMonthMeetingDates(int id, int month, int year) async {
    loading = true;
    update();

    // var endpoint = await datesOfCalendarMeetingEndpoint(id, month, year);
    var endpoint1;
    var endpoint2;
    var endpoint3;

    if (month == 1) {
      endpoint1 = await datesOfCalendarMeetingEndpoint(id, 12, year - 1);
      endpoint2 = await datesOfCalendarMeetingEndpoint(id, month + 1, year);
      endpoint3 = await datesOfCalendarMeetingEndpoint(id, month, year);
    } else if (month == 12) {
      endpoint1 = await datesOfCalendarMeetingEndpoint(id, month - 1, year);
      endpoint2 = await datesOfCalendarMeetingEndpoint(id, 1, year + 1);
      endpoint3 = await datesOfCalendarMeetingEndpoint(id, month, year);
    } else {
      endpoint1 = await datesOfCalendarMeetingEndpoint(id, month - 1, year);
      endpoint2 = await datesOfCalendarMeetingEndpoint(id, month + 1, year);
      endpoint3 = await datesOfCalendarMeetingEndpoint(id, month, year);
    }

    var res = [];

    var res2 = [];

    // List dub = await api.getMonthMeetingDates(endpoint);
    res.add(await api.getMonthMeetingDates(endpoint1));

    res.add(await api.getMonthMeetingDates(endpoint2));
    res.add(await api.getMonthMeetingDates(endpoint3));

    for (var i = 0; i < res.length; i++) {
      res2.addAll(res[i]);
    }
    if (res2 != []) {
      var int = 0;
      res2.forEach((element) {
        var dateTime = Jiffy.parse(element, pattern: 'yyyy-MM-dd');
        int++;
        planets.addAll({int: dateTime.dateTime});
        // meetingListData.add(dateTime.dateTime);
      });

      update();
      // List<String> data = res;

      // DateTime.parse()
    }

    loading = false;
  }

  bool getEventsForDay(DateTime day) {
    loading = true;
    // final kEvents = LinkedHashMap<int, DateTime>(
    //   equals: isSameDay,
    //   hashCode: getHashCode,
    // )..addAll(calendarController.planets);
    print(planets.values);

    var dateTime = Jiffy.parse(day.toString(), pattern: 'yyyy-MM-dd');
    print(dateTime.dateTime);

    print(planets.values == dateTime.dateTime);
    var data = planets.containsValue(dateTime.dateTime);

    print(data);
    // print(kEvents[day]);

    isEventDay = data;
    loading = false;
    return isEventDay;

    // return data;

    // if (data != null) {
    //   return true;
    // } else {
    //   return false;
    //   // return kEvents[day] ?? [];
    // }

    // Implementation example
    // print(kEvents[day]);

    // if (kEvents[day] != null) {
    //   return true;
    // } else {
    //   return false;
    //   // return kEvents[day] ?? [];
    // }
  }

  // void datesHaveMeetings() {
  //   notifyListeners();
  // }

  bool thisMonthHaveEvent = false;

  tableCalendarSwipeEvent(month, year) async {
    print('object');
    loading = true;

    thisMonthHaveEvent = !thisMonthHaveEvent;

    await Future.delayed(Duration(seconds: 2));
    loading = false;
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
