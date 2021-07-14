import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/utils/local_data.dart';

class MyLanguageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'settingPage_LanguageDialog_Title'.tr,
      ),
      children: [
        SimpleDialogOption(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/flag-China.png',
                width: 30,
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text("settingPage_LanguageDialog_Chinese".tr),
              )
            ],
          ),
          onPressed: () {
            var locale = Locale('zh', 'CN');
            Get.arguments['language'].value = '简体中文';
            DataUtil.preferences.setString("AppLanguage", "ZH");
            Get.updateLocale(locale);
            Get.back();
          },
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/flag-USA.png',
                width: 30,
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text("settingPage_LanguageDialog_English".tr),
              ),
            ],
          ),
          onPressed: () {
            var locale = Locale('en', 'US');
            Get.arguments['language'].value = 'English-USA';
            DataUtil.preferences.setString("AppLanguage", "US");
            Get.updateLocale(locale);
            Get.back();
          },
        )
      ],
    );
  }
}
