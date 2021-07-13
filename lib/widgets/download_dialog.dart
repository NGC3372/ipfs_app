import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/utils/http.dart';
import 'package:ipfs_app/widgets/my_textField.dart';

import 'my_button.dart';

// ignore: must_be_immutable
class MyDownloadDialog extends StatelessWidget {
  var searched = true.obs;
  final MyTextFeild myTextFeild = MyTextFeild(
    hintText: 'downloadDialog_Hint'.tr,
  );

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('downloadDialog_Title'.tr),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: myTextFeild,
            ),
            SizedBox(
              height: 20,
            ),
            MyTextButton(
              tap: () {
                searchFile(myTextFeild.textValue);
              },
              text: 'downloadDialog_Button'.tr,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20,
              child: Obx(() => Offstage(
                    child: Text(
                      'downloadDialog_failure'.tr,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    offstage: searched.value,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Future searchFile(String hash) async {
    searched.value = true;
    var response = await MyHttp.getDownloadInfo(hash);

    if (response != null) {
      String hash = response.data['Hash'];
      int fileSize = response.data['CumulativeSize'];
      DateTime date = new DateTime.now();
      Get.offNamed('downloadInfoPage', arguments: {
        "hash": hash,
        "fileSize": fileSize,
        "date": date.toString().split('.')[0]
      });
    } else {
      searched.value = false;
    }
  }
}
