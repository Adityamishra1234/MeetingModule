import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomImageViewer extends StatelessWidget {
  String url;
  CustomImageViewer({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                url,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: getLoading(context));
                  //   CircularProgressIndicator(
                  //     value: loadingProgress.expectedTotalBytes != null
                  //         ? loadingProgress.cumulativeBytesLoaded /
                  //             loadingProgress.expectedTotalBytes!
                  //         : null,
                  //   ),
                  // );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                      color: ThemeConstants.whitecolor,
                      alignment: Alignment.center,
                      child: CustomAutoSizeTextMontserrat(
                        text:
                            "SomeThing went wrong \n Please try after some time !!",
                        textColor: ThemeConstants.TextColor,
                        fontWeight: FontWeight.bold,
                      ));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ThemeConstants.lightgreycolor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: ThemeConstants.blackcolor,
                      size: 30,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
