import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomDocumentViewer extends StatefulWidget {
  String url;
  CustomDocumentViewer({Key? key, required this.url}) : super(key: key);
  @override
  State<CustomDocumentViewer> createState() => _CustomDocumentViewerState();
}

class _CustomDocumentViewerState extends State<CustomDocumentViewer> {
  late final WebViewController controller;
  bool loading = false;
  bool errorMessage = false;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              loading = true;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print("object");
            print(error.description);
            print(error.errorCode);
            print(error.errorType);
            print(error.isForMainFrame);
            setState(() {
              print("object");
              errorMessage = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "http://docs.google.com/gview?embedded=true&url=${widget.url}"));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == false
          ? getLoading(context)
          : Stack(
              children: [
                errorMessage == true
                    ? Container(
                        color: ThemeConstants.whitecolor,
                        alignment: Alignment.center,
                        child: CustomAutoSizeTextMontserrat(
                          text:
                              "SomeThing went wrong \n Please try after some time !!",
                          textColor: ThemeConstants.TextColor,
                          fontWeight: FontWeight.bold,
                        ))
                    : SafeArea(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: WebViewWidget(controller: controller)),
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
                            context.pop();
                            // Get.back();
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
