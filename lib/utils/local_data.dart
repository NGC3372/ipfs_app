import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtil {
  static SharedPreferences preferences;
  static String appDocPath;
  static String downloadListPath;

  static Future getInstance() async {
    preferences = await SharedPreferences.getInstance();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    appDocPath = appDocDir.path + '/download/';
    downloadListPath = appDocDir.path;
  }

  static Icon setFileType(String typeStr) {
    Icon type;
    switch (typeStr) {
      case 'text/html':
        type = Icon(Icons.web,
            size: 40, color: Get.isDarkMode ? Colors.white : Colors.red);
        break;
      case 'audio':
        type = Icon(Icons.audiotrack,
            size: 40, color: Get.isDarkMode ? Colors.white : Colors.red);
        break;
      case 'video':
        type = Icon(Icons.video_call,
            size: 40, color: Get.isDarkMode ? Colors.white : Colors.red);
        break;
      case 'picture':
        type = Icon(Icons.picture_in_picture,
            size: 40, color: Get.isDarkMode ? Colors.white : Colors.red);
        break;
    }
    return type;
  }

  static void initAppSetting() {
    String requestURI = DataUtil.preferences.getString("RequestURI");
    if (requestURI == null) {
      DataUtil.preferences.setString('RequestURI', 'https://www.guohao.icu');
    }
    String language = DataUtil.preferences.getString("AppLanguage");
    if (language == null) {
      DataUtil.preferences.setString("AppLanguage", 'ZH');
      language = 'ZH';
    }
    bool darkMode = DataUtil.preferences.getBool('AppDarkMode');
    if (darkMode == null) {
      DataUtil.preferences.setBool("AppDarkMode", false);
      darkMode = false;
    }

    DataUtil.preferences.getString('AppLanguage') == "ZH"
        ? Get.updateLocale(Locale('zh', 'CN'))
        : Get.updateLocale(Locale('en', 'US'));

    DataUtil.preferences.getBool('AppDarkMode')
        ? Get.changeTheme(ThemeData.dark())
        : Get.changeTheme(ThemeData(
            primarySwatch: Colors.red,
          ));
  }
}
