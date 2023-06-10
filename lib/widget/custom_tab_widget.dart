import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:untitled3/custom_widget/custom_tab/custom_tab_list.dart';
// import 'package:untitled3/custom_widget/custom_timer/custom_timer_widget.dart';

typedef void StringCallback(String val);

class CustomTabWidget extends StatefulWidget {
  final String title0;
  final String title1;
  final Function callback;

  const CustomTabWidget(
      {super.key,
      required this.title0,
      required this.title1,
      required this.callback});

  @override
  State<CustomTabWidget> createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget> {
  // List data = CustomTabList.tabData;
  int indexOfTab = 0;
  int firstTextlength = 0;
  int secondTextlength = 0;

  @override
  void initState() {
    firstTextlength = widget.title0.length;
    secondTextlength = widget.title1.length;
    print(firstTextlength);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        // color: Colors.amber,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 0),
        child: Container(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              child: Text(
                                '${widget.title0}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: indexOfTab != 0
                                        ? Colors.black
                                        : Color(0xffff9900)),
                              ),
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
                            child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              child: Text(
                                '${widget.title1}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: indexOfTab != 1
                                        ? Colors.black
                                        : Color(0xffff9900)),
                              ),
                            ),
                          )))
                ],

                ////Animated below bar
              ),
              AnimatedPositioned(
                width: indexOfTab == 0
                    ? firstTextlength / 2 * 10
                    : secondTextlength / 2 * 10,
                height: 2.5,
                top: 43,
                left: indexOfTab == 0 ? 4 : firstTextlength * 10 + 34,
                duration: const Duration(milliseconds: 1000),
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
        ));
  }
}
