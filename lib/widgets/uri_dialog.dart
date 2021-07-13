import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/utils/local_data.dart';
import 'package:ipfs_app/widgets/my_textField.dart';

import 'my_button.dart';

class UriDialog extends StatelessWidget {
  final MyTextFeild textFeild = MyTextFeild(
    hintText: 'uri',
  );
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('URI'),
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: Text(
                "settingPage_URIDialog_content".tr,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                textFeild.textValue = 'https://www.guohao.icu';
              },
            )),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: textFeild,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextButton(
                tap: () {
                  DataUtil.preferences
                      .setString("RequestURI", textFeild.textValue);
                  Get.arguments['uri'].value = textFeild.textValue;
                  Get.back();
                },
                text: 'settingPage_URIDialog_OK'.tr),
          ],
        )
      ],
    );
  }
}
