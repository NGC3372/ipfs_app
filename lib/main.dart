import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/download_info_page.dart';
import 'package:ipfs_app/page_two.dart';
import 'package:ipfs_app/picture_page.dart';
import 'package:ipfs_app/text_page.dart';
import 'package:ipfs_app/video_page.dart';

import 'audio_page.dart';
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
      ),
      GetPage(name: "downloadInfoPage", page: () => DownloadInfoPage()),
      GetPage(name: 'picturePage', page: () => PicturePage()),
      GetPage(name: 'textPage', page: () => TextPage()),
      GetPage(name: 'videoPage', page: () => VideoPage()),
      GetPage(name: 'audioPage', page: () => AudioPage()),
    ],
  ));
}
