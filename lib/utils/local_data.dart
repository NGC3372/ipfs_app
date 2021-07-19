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
      case 'media':
        type = Icon(Icons.movie,
            size: 40, color: Get.isDarkMode ? Colors.white : Colors.red);
        break;
      case 'picture':
        type = Icon(Icons.photo,
            size: 40, color: Get.isDarkMode ? Colors.white : Colors.red);
        break;
    }
    return type;
  }

  static void initAppSetting() {
    String requestURI = DataUtil.preferences.getString("RequestURI");
    if (requestURI == null) {
      DataUtil.preferences.setString('RequestURI', 'https://ipfs.io');
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
        : Get.changeTheme(
            ThemeData(primaryColor: Color.fromRGBO(28, 122, 124, 1.0)));
  }

  static String formatFileSize(int sizeInt) {
    double size = sizeInt.toDouble();
    if (size > 0 && size < 999) {
      return '${size.toString()}b';
    } else if (size > 999 && size < 999999) {
      String temp = (size / 1000).toString();
      return '${temp.substring(0, temp.indexOf('.') + 2)}Kb';
    } else if (size > 999999 && size < 999999999) {
      String temp = (size / 1000000).toString();
      return '${temp.substring(0, temp.indexOf('.') + 2)}Mb';
    } else if (size > 999999999) {
      String temp = (size / 1000000000).toString();
      return '${temp.substring(0, temp.indexOf('.') + 2)}Gb';
    }
  }
}
