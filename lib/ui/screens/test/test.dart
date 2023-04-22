import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';

class Test extends StatefulWidget {
  List<String> tablist;
  List<Widget> listWidget;
  Test({Key? key, required this.tablist, required this.listWidget});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  static late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 11);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: DefaultTabController(
          length: 11,
          child: Column(
            children: [
              TabBar(
                  controller: _tabController,
                  labelColor: ThemeConstants.bluecolor,
                  indicatorColor: ThemeConstants.firstColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabs: getListTabbar(widget.tablist)),
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: widget.listWidget,
                ),
              ),
            ],
          ),
        ));
  }

  //Function
  List<Widget> getListTabbar(List<String> tabList) {
    List<Widget> temp = [];
    for (var element in tabList) {
      temp.add(
        Tab(
          text: element,
        ),
      );
    }
    return temp;
  }
}
