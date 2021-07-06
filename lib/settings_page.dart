import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  RxBool select = RxBool(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('settingsPage'),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(Icons.explore),
              title: Text('URI'),
              subtitle: Text('wwwww.gaga.com'),
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
                'www.sdfasdf.com',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                controller.text = 'www.sdfasdf.com';
              },
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            autofocus: true,
            controller: controller,
          ),
        ),
        TextButton(onPressed: () {}, child: Text('OK'))
      ],
    ));
  }
}
