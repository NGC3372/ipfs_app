import 'package:flutter/widgets.dart';

class DownloadInfo {
  String fileName;
  String hash;
  String date;
  Icon type;
  double progress = 0.0;

  DownloadInfo(this.fileName, this.hash, this.date, this.type);
}
