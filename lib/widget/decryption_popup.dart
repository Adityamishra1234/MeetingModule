import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/decryptionController.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class PopUpForDecryption extends StatelessWidget {
  PopUpForDecryption({super.key, required this.encyrptedNote});
  String encyrptedNote;
  TextEditingController password = TextEditingController();
  var decryptedNote = '';
  var controller = Get.put(DecryptionOfNotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Encrypted Note:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ThemeConstants.bluecolor)),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ThemeConstants.bluecolor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('${encyrptedNote}',
                      style: TextStyle(
                          color: ThemeConstants.blackcolor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(hint: 'Enter Password', controller: password),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  // if (type == true) {
                  //   await data(note, keyBaazi.text);
                  //   keyBaazi.clear();
                  // } else if (type == false) {

                  // print(pass.text);
                  decryptedNote = await controller.getdecryptedNote(
                      encyrptedNote, password.text);

                  // print(datatoShow);
                  // stateSetter(() {});
                  // }
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[300]!,
                    ),
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text('Decrypt')),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Decrypted Note:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ThemeConstants.bluecolor)),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ThemeConstants.bluecolor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Obx(
                  () => Container(
                    alignment: Alignment.topLeft,
                    child: HtmlWidget('${controller.decryptedNoteData.value}',
                        textStyle: TextStyle(
                            color: ThemeConstants.blackcolor,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
