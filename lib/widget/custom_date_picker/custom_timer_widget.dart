import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meeting_module2/utils/theme.dart';

typedef void StringCallback(String val);

class CustomTimerWidget extends StatefulWidget {
  final StringCallback callback;
  DateTime? startingDate;
  String? initialTime;
  bool? isBlank;
  Widget? field;

  CustomTimerWidget(
      {Key? key,
      this.field,
      this.isBlank,
      required this.callback,
      this.initialTime,
      this.startingDate})
      : super(key: key);

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget> {
  String finaldate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String date =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String previousDate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  late String dateToShow;

  late DateTime dateTime;

  late DateTime minimumDate;
  @override
  void initState() {
    if (widget.initialTime != null &&
        widget.initialTime != '' &&
        widget.initialTime != "0000-00-00" &&
        widget.initialTime != 'null') {
      String dateString = widget.initialTime!;
      dateTime = Jiffy.parse(dateString).dateTime;

      // String formattedDate = Jiffy(dateTime).format('MMM do yyyy');
      // print(formattedDate); // Output: Jun 13th 2023
      dateToShow = widget.initialTime ??
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    } else {
      print('object');
      dateToShow = widget.isBlank == true
          ? ''
          : '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

      dateTime = DateTime.now();
      // TODO: implement initState
      super.initState();
    }

    minimumDate = widget.startingDate ?? Jiffy.parse('1990/09/23').dateTime;
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   finaldate = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  //   date = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  //   previousDate = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  //   dateToShow = '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  //
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 30, right: 30),
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dateToShow = previousDate;
                              Navigator.pop(context);
                              widget.callback(dateToShow);
                            });
                          },
                          child: const Text('Previous'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              previousDate = date;
                              date = dateToShow;
                              widget.callback(dateToShow);
                            });
                          },
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        minimumDate: minimumDate,
                        initialDateTime: dateTime,
                        onDateTimeChanged: (DateTime newdate) {
                          setState(() {
                            dateToShow =
                                '${newdate.year}-${newdate.month}-${newdate.day}';
                          });
                          widget.callback(dateToShow);
                        },
                        maximumDate: DateTime(2040, 12, 30),
                        // minimumYear: 1,
                        // maximumYear: 2035,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.date,
                      ),
                    )
                  ],
                ),
              );
            }).whenComplete(() {
          setState(() {
            previousDate = date;
            date = dateToShow;

            widget.callback(dateToShow);
          });
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightblueColor,
                // border: Border.all(color: ThemeConstants.lightgreycolor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${dateToShow}', style: TextStyle(fontSize: 14)),
                const Icon(
                  Icons.calendar_month,
                  size: 20,
                )
              ],
            ),
          ),
          widget.field == null ? SizedBox.shrink() : widget.field!,
        ],
      ),
    );
  }
}
