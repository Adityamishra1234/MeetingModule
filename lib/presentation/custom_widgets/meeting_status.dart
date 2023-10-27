import 'package:flutter/material.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class MeetingStatus extends StatelessWidget {
  AllMeetings listToShow;

  MeetingStatus({super.key, required this.listToShow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          listToShow.meetingStarted! && !listToShow.meetingEnded!
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Transform.scale(
                    //   scale: 0.8,
                    //   child: Radio(
                    //       activeColor: Colors.green,
                    //       value: true,
                    //       groupValue: true,
                    //       onChanged: (val) {}),
                    // ),
                    Icon(
                      Icons.lock_outline_rounded,
                      color: ThemeConstants.GreenColor,
                    ),
                    CustomAutoSizeTextMontserrat(
                      fontSize: 10,
                      text: 'Started',
                      fontWeight: FontWeight.w500,
                      textColor: ThemeConstants.GreenColor,
                    )
                  ],
                )
              : SizedBox.shrink(),
          listToShow.meetingStarted! && listToShow.meetingEnded!
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Transform.scale(
                    //   scale: 0.8,
                    //   child: Radio(
                    //       activeColor: Colors.red,
                    //       value: true,
                    //       groupValue: true,
                    //       onChanged: (val) {}),
                    // ),
                    Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.red,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: 'Ended',
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      textColor: Colors.red,
                    )
                  ],
                )
              : SizedBox.shrink(),
          !listToShow.meetingStarted! && !listToShow.meetingEnded!
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Transform.scale(
                    //   scale: 0.8,
                    //   child: Radio(
                    //       activeColor: const Color.fromARGB(255, 114, 114, 114),
                    //       value: true,
                    //       groupValue: true,
                    //       onChanged: (val) {}),
                    // ),
                    Icon(
                      Icons.lock_outline_rounded,
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: 'Not Started',
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      textColor: const Color.fromARGB(255, 114, 114, 114),
                    )
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
