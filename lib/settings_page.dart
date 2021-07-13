import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/utils/local_data.dart';
import 'package:ipfs_app/widgets/uri_dialog.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  RxBool select = RxBool(DataUtil.preferences.getBool('AppDarkMode'));
  RxString uri = RxString(DataUtil.preferences.getString('RequestURI'));
  Color iconColor = Get.isDarkMode ? Colors.white : Get.theme.primaryColor;
  TextStyle textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    print(uri.value);
    return Scaffold(
        appBar: AppBar(
          title: Text('settingPage_title'.tr),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.explore,
                color: iconColor,
              ),
              title: Text(
                'settingPage_requestURI'.tr,
                style: textStyle,
              ),
              subtitle: Obx(() => Text(uri.value)),
              onTap: () {
                Get.dialog(UriDialog(), arguments: {'uri': uri});
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.language,
                color: iconColor,
              ),
              title: Text(
                'settingPage_language'.tr,
                style: textStyle,
              ),
              onTap: () {
                setLanguageDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.dark_mode,
                color: iconColor,
              ),
              title: Text(
                'settingPage_darkMode'.tr,
                style: textStyle,
              ),
              trailing: Obx(() => Switch(
                    value: select.value,
                    onChanged: (value) {
                      changeTheme(value);
                    },
                  )),
            ),
            Divider(),
          ],
        ));
  }

  void changeTheme(bool value) {
    select.value = !select.value;
    print('dark?');
    print(Get.isDarkMode);
    print(Get.isPlatformDarkMode);
    if (value)
      Get.changeTheme(ThemeData.dark());
    else
      Get.changeTheme(
        ThemeData(
          primarySwatch: Colors.red,
        ),
      );
    DataUtil.preferences.setBool("AppDarkMode", select.value);
  }

  void setLanguageDialog() {
    Get.dialog(SimpleDialog(
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
            DataUtil.preferences.setString("AppLanguage", "US");
            Get.updateLocale(locale);
            Get.back();
          },
        )
      ],
    ));
  }
}
