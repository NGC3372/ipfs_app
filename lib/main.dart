import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/page_two.dart';

import 'home_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: 'home',
    getPages: [
      GetPage(
        name: 'home',
        page: () => HomePage(),
        binding: BindingsBuilder(() => Get.put<ControlHome>(ControlHome())),
      ),
      GetPage(
        name: "settingsPage",
        page: () => SettingsPage(),
      )
    ],
  ));
}
