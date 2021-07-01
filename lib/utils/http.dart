import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/utils/local_data.dart';

class MyHttp {
  static Dio dio = Dio();
  static String testHash = "QmYgCkNQcu8NCTZAKo9ZeKpHGm8cpuQQvtHTRZedPD5Thw";
  static String testUri = "https://www.guohao.icu";

  static Future getDownloadInfo(String uri, String hash) async {
    try {
      var response = await dio.post(uri + '/api/v0/object/stat?arg=' + hash);

      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  static Future downloadFile(
      String uri, String hash, int fileSize, int listIndex) async {
    await dio.download(
        uri + '/api/v0/cat?arg=' + hash, DataUtil.appDocPath + "\\file",
        onReceiveProgress: (received, total) {
      Get.find<ControlHome>().downloadedInfo[listIndex].progress.value =
          double.tryParse((received / fileSize).toStringAsFixed(2));
      print(Get.find<ControlHome>().downloadedInfo[0].progress.value);
    });
    Get.find<ControlHome>().downloadedInfo[listIndex].done.value = true;
  }
}
