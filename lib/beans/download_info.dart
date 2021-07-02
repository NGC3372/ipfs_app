import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/utils/local_data.dart';

class DownloadInfo {
  String fileName;
  String hash;
  String date;
  String type;
  var progress = 0.0.obs;
  var done = false.obs;

  DownloadInfo(this.fileName, this.hash, this.date, this.type);

  Map toMap() {
    return {
      'fileName': fileName,
      'hash': hash,
      'date': date,
      'type': type,
    };
  }
}
