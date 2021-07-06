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
          title: Text('settingsPage'),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.explore),
              title: Text('URI'),
              subtitle: Obx(() => Text(uri.value)),
              onTap: () {
                setUriDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('DarkMode'),
              trailing: Obx(() => Switch(
                    value: select.value,
                    onChanged: (value) {
                      select.value = !select.value;
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
                "默认: https://www.guohao.icu",
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
            child: Text('OK'))
      ],
    ));
  }
}
