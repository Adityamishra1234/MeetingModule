import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/controollerer.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';

class MyWidget extends StatelessWidget {
  final controller = Get.put(Controdddddddd());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Get.to(DashBoard());
            },
            child: Text('dd'),
          ),
        ),
      ),
    );
  }
}
