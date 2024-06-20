import 'package:flutter/widgets.dart';

getLoading(BuildContext context) {
  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width * 0.50,
      child: Image.asset(
        "assets/images/loading1.gif",
        gaplessPlayback: false,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.contain,
      ),
    ),
  );
}
