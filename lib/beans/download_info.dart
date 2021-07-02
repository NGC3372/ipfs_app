import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DownloadInfo {
  String fileName;
  String hash;
  String date;
  Icon type;
  var progress = 0.0.obs;
  var done = false.obs;

  DownloadInfo(this.fileName, this.hash, this.date, this.type);
}
