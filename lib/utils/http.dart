import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/utils/local_data.dart';

class MyHttp {
  static Dio dio = Dio();

  static Future getDownloadInfo(String hash) async {
    String uri = DataUtil.preferences.getString("RequestURI");
    try {
      var response = await dio.post(uri + '/api/v0/object/stat?arg=' + hash);
      return response;
    } on DioError catch (e) {
      print('erro!!!!!!!');
      print(e.response);
      return null;
    }
  }

  static Future downloadFile(
      String hash, int fileSize, int listIndex, String fileName) async {
    String uri = DataUtil.preferences.getString("RequestURI");
    await dio.download(uri + '/api/v0/cat?arg=' + hash,
        DataUtil.appDocPath + "/$hash$fileName",
        onReceiveProgress: (received, total) {
      Get.find<ControlHome>().downloadedInfo[listIndex].progress.value =
          double.tryParse((received / fileSize).toStringAsFixed(2));
      print(Get.find<ControlHome>().downloadedInfo[0].progress.value);
    });
    Get.find<ControlHome>().downloadedInfo[listIndex].done.value = true;
  }
}
