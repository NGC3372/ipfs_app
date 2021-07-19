import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/change_file_info_page.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/download_info_page.dart';
import 'package:ipfs_app/settings_page.dart';
import 'package:ipfs_app/picture_page.dart';
import 'package:ipfs_app/search_page.dart';
import 'package:ipfs_app/text_page.dart';
import 'package:ipfs_app/utils/language.dart';
import 'package:ipfs_app/media_page.dart';
import 'dart:ui' as ui;
import 'home_page.dart';

void main() {
  runApp(GetMaterialApp(
    translations: MyLanguage(),
    locale: ui.window.locale,
    theme: ThemeData(primaryColor: Color.fromRGBO(28, 122, 124, 1.0)),
    themeMode: Get.isPlatformDarkMode ? ThemeMode.light : ThemeMode.dark,
    fallbackLocale: Locale('en', 'US'),
    initialRoute: 'home',
    getPages: [
      GetPage(
        name: 'home',
        page: () => HomePage(),
        binding: BindingsBuilder(() => Get.put<ControlHome>(ControlHome())),
      ),
      GetPage(name: "settingsPage", page: () => SettingsPage()),
      GetPage(name: "downloadInfoPage", page: () => DownloadInfoPage()),
      GetPage(name: 'picturePage', page: () => PicturePage()),
      GetPage(name: 'textPage', page: () => TextPage()),
      GetPage(name: 'mediaPage', page: () => MediaPage()),
      GetPage(name: 'searchPage', page: () => SearchPage()),
      GetPage(name: 'changeFileInfoPage', page: () => ChangeFileInfoPage()),
    ],
  ));
}
