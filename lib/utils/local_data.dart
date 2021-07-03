import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Icon type = Icon(Icons.file_copy);
    switch (typeStr) {
      case 'text/html':
        type = Icon(Icons.web);
        break;
      case 'audio':
        type = Icon(Icons.audiotrack);
        break;
      case 'video':
        type = Icon(Icons.video_call);
        break;
      case 'picture':
        type = Icon(Icons.picture_in_picture);
        break;
    }
    return type;
  }
}
