import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/utils/local_data.dart';

import 'my_button.dart';

class UriDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
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
                controller.text = 'https://www.guohao.icu';
              },
            )),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                autofocus: true,
                controller: controller,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyTextButton(
                tap: () {
                  DataUtil.preferences.setString("RequestURI", controller.text);
                  Get.arguments['uri'].value = controller.text;
                  Get.back();
                },
                text: 'settingPage_URIDialog_OK'),
          ],
        )
      ],
    );
  }
}
