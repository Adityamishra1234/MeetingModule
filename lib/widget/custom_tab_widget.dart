import 'package:flutter/material.dart';
// import 'package:untitled3/custom_widget/custom_tab/custom_tab_list.dart';
// import 'package:untitled3/custom_widget/custom_timer/custom_timer_widget.dart';

typedef void StringCallback(String val);

class CustomTabWidget extends StatefulWidget {
  final String title0;
  final String title1;
  final Function callback;
  final int? defaultIndex;

  const CustomTabWidget(
      {super.key,
      this.defaultIndex,
      required this.title0,
      required this.title1,
      required this.callback});

  @override
  State<CustomTabWidget> createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget> {
  // List data = CustomTabList.tabData;
  late int indexOfTab;
  int firstTextlength = 0;
  int secondTextlength = 0;

  @override
  void initState() {
    indexOfTab = widget.defaultIndex ?? 0;
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
    print(firstTextlength);
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
                          indexOfTab = 0;
                          print(indexOfTab);
                          widget.callback(indexOfTab);
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
                          style: TextStyle(
                              fontSize: 18,
                              color: indexOfTab != 0
                                  ? Colors.black
                                  : Color(0xffff9900)),
                        ),
                      ))),

              ///Middle Space

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
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          '${widget.title1}',
                          style: TextStyle(
                              fontSize: 18,
                              color: indexOfTab != 1
                                  ? Colors.black
                                  : Color(0xffff9900)),
                        ),
                      )))
            ],

            ////Animated below bar
          ),
          AnimatedPositioned(
            width: indexOfTab == 0 ? firstTextlength / 2 : secondTextlength / 2,
            height: 2.5,
            top: 43,
            left: indexOfTab == 0 ? 4 : firstTextlength + 34,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xffff9900),
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
