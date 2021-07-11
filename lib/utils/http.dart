import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/utils/local_data.dart';

class MyHttp {
  static Dio dio = Dio();

  static Future getDownloadInfo(String hash) async {
    String uri = DataUtil.preferences.getString("RequestURI") +
        '/api/v0/object/stat?arg=' +
        hash;
    print(uri);

    try {
      var response = await dio.post(uri);
      return response;
    } on DioError catch (e) {
      print('error!!!!!!!');
      print(e.response);
      return null;
    }
  }

  static Future downloadFile(
      String hash, int fileSize, int listIndex, String fileName) async {
    String uri = DataUtil.preferences.getString("RequestURI") +
        '/api/v0/cat?arg=' +
        hash;
    print(uri);
    await dio.download(uri, DataUtil.appDocPath + "/$hash",
        onReceiveProgress: (received, total) {
      Get.find<ControlHome>().downloadedInfo[listIndex].progress.value =
          double.tryParse((received / fileSize).toStringAsFixed(2));
      print(Get.find<ControlHome>().downloadedInfo[0].progress.value);
    });
    Get.find<ControlHome>().downloadedInfo[listIndex].done.value = true;
  }
}
