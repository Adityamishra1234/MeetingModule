import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meeting_module2/utils/theme.dart';

typedef void StringCallback(String val);

class CustomTimerWidget2 extends StatefulWidget {
  final StringCallback callback;
  String? initialTime;
  CustomTimerWidget2({Key? key, required this.callback, this.initialTime})
      : super(key: key);

  @override
  State<CustomTimerWidget2> createState() => _CustomTimerWidget2State();
}

class _CustomTimerWidget2State extends State<CustomTimerWidget2> {
  String finaldate = '${DateTime.now().hour}:${DateTime.now().minute}';
  String date = '${DateTime.now().hour}:${DateTime.now().minute}';
  String previousDate = '${DateTime.now().hour}:${DateTime.now().minute}';
  late String dateToShow;
  late DateTime dateTime;

  @override
  void initState() {
    if (widget.initialTime != null) {
      String dateString = widget.initialTime!;
      dateTime = Jiffy.parse(dateString, pattern: 'HH:mm').dateTime;
      dateToShow = widget.initialTime ??
          '${DateTime.now().hour}:${DateTime.now().minute}';
    } else {
      dateToShow = '${DateTime.now().hour}:${DateTime.now().minute}';
      dateTime = DateTime.now();
    }

    // TODO: implement initState
    super.initState();
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
                              widget.callback(date);
                            });
                          },
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        use24hFormat: true,
                        initialDateTime: dateTime,
                        onDateTimeChanged: (DateTime newdate) {
                          setState(() {
                            dateToShow = '${newdate.hour}:${newdate.minute}';
                          });
                          widget.callback(dateToShow);
                        },
                        // maximumDate: DateTime(2025, 12, 30),
                        // minimumYear: 2010,
                        // maximumYear: 2035,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.time,
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
        width: double.infinity,
        // height: 50,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: ThemeConstants.lightgreycolor, width: 1),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${dateToShow}', style: TextStyle(fontSize: 14)),
            const Icon(
              Icons.access_time,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
