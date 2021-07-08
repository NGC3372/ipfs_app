import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/utils/local_data.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  RxBool select = RxBool(DataUtil.preferences.getBool('AppDarkMode'));
  RxString uri = RxString(DataUtil.preferences.getString('RequestURI'));

  @override
  Widget build(BuildContext context) {
    print(uri.value);
    return Scaffold(
        appBar: AppBar(
          title: Text('settingPage_title'.tr),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.explore),
              title: Text('settingPage_requestURI'.tr),
              subtitle: Obx(() => Text(uri.value)),
              onTap: () {
                setUriDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('settingPage_language'.tr),
              onTap: () {
                setLanguageDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('settingPage_darkMode'.tr),
              trailing: Obx(() => Switch(
                    value: select.value,
                    onChanged: (value) {
                      select.value = !select.value;
                      if (select.value)
                        Get.changeTheme(ThemeData.dark());
                      else
                        Get.changeTheme(ThemeData.light());
                      DataUtil.preferences.setBool("AppDarkMode", select.value);
                    },
                  )),
            ),
            Divider(),
          ],
        ));
  }

  void setUriDialog() {
    TextEditingController controller = TextEditingController();
    Get.dialog(SimpleDialog(
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            autofocus: true,
            controller: controller,
          ),
        ),
        TextButton(
            onPressed: () {
              DataUtil.preferences.setString("RequestURI", controller.text);
              uri.value = controller.text;
              Get.back();
            },
            child: Text('settingPage_URIDialog_OK'.tr))
      ],
    ));
  }

  void setLanguageDialog() {
    Get.dialog(SimpleDialog(
      title: Text('settingPage_LanguageDialog_Title'.tr),
      children: [
        SimpleDialogOption(
          child: Text("settingPage_LanguageDialog_Chinese".tr),
          onPressed: () {
            var locale = Locale('zh', 'CN');
            Get.updateLocale(locale);
            Get.back();
          },
        ),
        SimpleDialogOption(
          child: Text("settingPage_LanguageDialog_English".tr),
          onPressed: () {
            var locale = Locale('en', 'US');
            Get.updateLocale(locale);
            Get.back();
          },
        )
      ],
    ));
  }
}
