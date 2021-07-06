import 'package:get/get.dart';

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
