import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class AddRepresentative extends StatelessWidget {
  static const routeNamed = '/AddRepresentative';
  const AddRepresentative({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Create \nNew  Meeting",
                fontSize: 35,
                textColor: ThemeConstants.bluecolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Representative Type",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Country",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "University Name",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Name of Person",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Email",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Designation",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Phone",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: ThemeConstants.lightgreycolor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          Container(
            height: 38,
            width: 150,
            decoration: BoxDecoration(
                color: ThemeConstants.bluecolor,
                borderRadius: const BorderRadius.all(Radius.circular(30.0))),
            child: Center(
              child: CustomAutoSizeTextMontserrat(
                text: "Add",
                textColor: ThemeConstants.whitecolor,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
