import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

getLoading(BuildContext context) {
  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width * 0.50,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitChasingDots(
            duration: const Duration(milliseconds: 1500),
            color:  Color(0xff3088C6),
            size: 45,
          ),
          const SizedBox(height: 12,),
          CustomAutoSizeTextMontserrat( align: TextAlign.center, fontSize: ThemeConstants.fontSizeMedium,text: "${ThemeConstants.setBackgroundTexts()}", textColor: Colors.black, fontWeight: FontWeight.w500,)
        ],
      )
      // Image.asset(
      //   "assets/images/loading1.gif",
      //   gaplessPlayback: false,
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   fit: BoxFit.contain,
      // ),
    ),
  );
}


