import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:untitled3/custom_widget/custom_tab/custom_tab_list.dart';
// import 'package:untitled3/custom_widget/custom_timer/custom_timer_widget.dart';

typedef void StringCallback(String val);

class CustomTabWidget2 extends StatefulWidget {
  final String title0;
  final String title1;
  final String title2;
  final Function callback;
  final int? defaultIndex;
  final Function? changeOfIndexFromParent;
  bool? dontChangeTab;

  CustomTabWidget2(
      {super.key,
      this.changeOfIndexFromParent,
      this.defaultIndex,
      this.dontChangeTab,
      required this.title0,
      required this.title1,
      required this.callback,  this.title2 = ""});

  static GlobalKey<CustomTabWidget2State> globalKey = GlobalKey();

  @override
  State<CustomTabWidget2> createState() => CustomTabWidget2State();
}

class CustomTabWidget2State extends State<CustomTabWidget2> {
  // List data = CustomTabList.tabData;
  late int indexOfTab;
  int firstTextlength = 0;
  int secondTextlength = 0;

  int thirdTextlength = 0;

  changeOfIndexFromParent(val) {
    if (val == 0) {
      indexOfTab = 1;
    }
    else if(val == 1){
      indexOfTab = 2;
    }
    else {
      indexOfTab = 0;
    }
    setState(() {});
  }

  @override
  void initState() {
    indexOfTab = widget.defaultIndex ?? 0;
    // widget.callback(widget.defaultIndex);

    final Size txtSize3 = _textSize(
        widget.title2,
        TextStyle(
          fontSize: 18,
          color: indexOfTab == 2 ? Colors.black : Color(0xffff9900),
        ),
    );
    final Size txtSize = _textSize(
      widget.title0,
      TextStyle(
          fontSize: 18,
          color: indexOfTab != 0 ? Colors.black : Color(0xffff9900)),
    );

    final Size txtSize2 = _textSize(
      widget.title1,
      TextStyle(
          fontSize: 18,
          color: indexOfTab != 1 ? Colors.black : Color(0xffff9900)),
    );
    firstTextlength = txtSize.width.toInt();
    secondTextlength = txtSize2.width.toInt();

    thirdTextlength = txtSize3.width.toInt();

    print(firstTextlength);
    print(thirdTextlength);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ////Tab1

              Container(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.dontChangeTab != null) {
                          } else {
                            indexOfTab = 0;
                            print(indexOfTab);
                            widget.callback(indexOfTab);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          '${widget.title0}',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                                fontSize: 18,
                                color: indexOfTab != 0
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 255, 255, 255)),
                          )
                        ),
                      ))),

              const SizedBox(
                width: 20,
              ),
              ////Tab1
              Container(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          indexOfTab = 1;
                          widget.callback(indexOfTab);
                          print(indexOfTab);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          '${widget.title1}',
                          style: TextStyle(
                              fontSize: 18,
                              color: indexOfTab != 1
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ))),
              const SizedBox(
                width: 20,
              ),
              Container(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          indexOfTab = 2;
                          widget.callback(indexOfTab);
                          print(indexOfTab);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          '${widget.title2}',
                          style: TextStyle(
                              fontSize: 18,
                              color: indexOfTab != 2
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ))),
            ],

            ////Animated below bar
          ),
          AnimatedPositioned(
            // width: indexOfTab == 0 ? firstTextlength/1 : secondTextlength/0.8,
            width: indexOfTab == 0 ? firstTextlength/1 : (indexOfTab == 1 ? secondTextlength/0.8 : (indexOfTab == 2)? thirdTextlength/0.8: 0),
            height: 1.5,
            top: 45,
            left: indexOfTab == 0 ? 2 : firstTextlength + 49,
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceOut,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
