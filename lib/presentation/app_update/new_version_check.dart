import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meeting_module2/presentation/app_update/const.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class NewVersionCheck {
  BuildContext? context;
  String? androidPackageName;
  String? iosPackageName;
  String? currentVersion;
  String? updateImage;

  NewVersionCheck.newVersionCheck(
      this.context, this.androidPackageName, this.iosPackageName,
      {this.updateImage}) {
    getVersion();
    newVersionCheck();
  }

  Future getVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      currentVersion = packageInfo.version;
    });
  }

  void newVersionCheck() {
    if (Platform.isAndroid) {
      _checkPlayStore(androidPackageName!);
    } else {
      _checkAppleStore(iosPackageName!);
    }
  }

  _checkPlayStore(String packageName) async {
    String? errorMsg;
    String? newVersion;
    String? url;
    final uri = Uri.https(
        "play.google.com", "/store/apps/details", {"id": packageName});
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        errorMsg =
            "Can't find an app in the Google Play Store with the id: $packageName";
      } else {
        //   print(response.body);
        newVersion = RegExp(r',\[\[\["([0-9,\.]*)"]],')
            .firstMatch(response.body)!
            .group(1);
        url = uri.toString();
        //  newVersionAlert(context!, newVersion!, url);
        if (newVersion != currentVersion) {
          newVersionAlert(context!, newVersion!, url);
        }
        print(newVersion);
      }
    } catch (e) {
      errorMsg = "$e";
    }
  }

  _checkAppleStore(String packageName) async {
    String? errorMsg;
    String? newVersion;
    String? url;
    var uri =
        Uri.https("itunes.apple.com", "/lookup", {"bundleId": packageName});
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        errorMsg =
            "Can't find an app in the Apple Store with the id: $packageName";
      } else {
        final jsonObj = jsonDecode(response.body);
        final List results = jsonObj['results'];
        if (results.isEmpty) {
          errorMsg =
              "Can't find an app in the Apple Store with the id: $packageName";
        } else {
          newVersion = jsonObj['results'][0]['version'];
          url = jsonObj['results'][0]['trackViewUrl'];
          if (newVersion != currentVersion) {
            newVersionAlert(context!, newVersion!, url!);
          }
          print(newVersion);
        }
      }
    } catch (e) {
      errorMsg = "$e";
    }
  }

  void newVersionAlert(BuildContext context, String newVersion, String url) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // title: Text(title + " !"),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: updateImage != null
                  ? Image.asset(updateImage!)
                  : Image.memory(base64Decode(ConsT.updateIcon)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Update Your App.!",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "New version available $newVersion",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black54, wordSpacing: 1),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                openAnyUrl(url);
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.black,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       )),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text("Not Now"),
            // )
          ],
        ),
      ),
    );
  }

  Future<void> openAnyUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
