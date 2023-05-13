import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomFilterSelector extends StatefulWidget {
  Function callBack;
  CustomFilterSelector({super.key, required this.callBack});

  @override
  State<CustomFilterSelector> createState() => _CustomFilterSelectorState();
}

class _CustomFilterSelectorState extends State<CustomFilterSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );

    super.initState();
  }

  String toShow = 'All Meetings';

  bool checkListIsOpened = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checkListIsOpened) {
          checkListIsOpened = !checkListIsOpened;
          _controller.reverse(from: 0.5);
        } else {
          checkListIsOpened = !checkListIsOpened;
          _controller.forward(from: 0.25);
        }

        widget.callBack(checkListIsOpened);
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            color: ThemeConstants.ultraLightgreyColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ThemeConstants.blackcolor)),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          children: [
            Text(
              '$toShow',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              width: 30,
              child: RotationTransition(
                turns: Tween(begin: 1.25, end: 2.25).animate(_controller),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
