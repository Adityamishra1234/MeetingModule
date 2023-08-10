import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';

typedef void StringCallback(String val);

class CustomTimerWidgetForHourMinutes extends StatefulWidget {
  final Function callback;
  String? initialTime;
  bool? isBlank;
  CustomTimerWidgetForHourMinutes(
      {Key? key, this.isBlank, this.initialTime, required this.callback})
      : super(key: key);

  @override
  State<CustomTimerWidgetForHourMinutes> createState() =>
      _CustomTimerWidgetForHourMinutesState();
}

class _CustomTimerWidgetForHourMinutesState
    extends State<CustomTimerWidgetForHourMinutes> {
  // String finaldate = '${DateTime.now().hour}:${DateTime.now().minute}';
  // String date = '${DateTime.now().hour}:${DateTime.now().minute}';
  // String previousDate = '${DateTime.now().hour}:${DateTime.now().minute}';
  String dateToShow = '${DateTime.now().hour}:${DateTime.now().minute}';

  late DateTime dateTime;
  late int intialDuration;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.initialTime);

    if (widget.initialTime != null) {
      int hours = int.parse(widget.initialTime!.split(' ')[0]);
      int minutes = int.parse(widget.initialTime!.split(' ')[2]);
      print('${hours}:${minutes}');
      intialDuration = hours * 60 + minutes;
      dateToShow = '${hours}:${minutes}';
    } else {
      intialDuration = 0;
      dateToShow = '00:00';
    }

    // finaldate =
    //     '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    // date =
    //     '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    // previousDate =
    //     '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  }

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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           dateToShow = previousDate;
                    //           Navigator.pop(context);
                    //           widget.callback(dateToShow);
                    //         });
                    //       },
                    //       child: const Text('Previous'),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //         setState(() {
                    //           previousDate = date;
                    //           date = dateToShow;
                    //           widget.callback(date);
                    //         });
                    //       },
                    //       child: const Text('Done'),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        initialTimerDuration: Duration(minutes: intialDuration),
                        // use24hFormat: true,
                        // initialDateTime: DateTime.now(),
                        onTimerDurationChanged: (Duration newdate) {
                          var hours = newdate.inMinutes / 60;

                          var realhours = hours.floor();
                          var minutes = newdate.inMinutes % 60;
                          // print('${realhours}:${minutes}');
                          setState(() {
                            dateToShow =
                                '${realhours > 9 ? realhours : '0$realhours'}:${minutes > 9 ? minutes : '0$minutes'}';
                          });
                          widget.callback(dateToShow);
                        },
                        // maximumDate: DateTime(2025, 12, 30),
                        // minimumYear: 2010,
                        // maximumYear: 2035,
                        minuteInterval: 1,
                        // mode: CupertinoDatePickerMode.time,
                      ),
                    )
                  ],
                ),
              );
            }).whenComplete(() {
          setState(() {
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
