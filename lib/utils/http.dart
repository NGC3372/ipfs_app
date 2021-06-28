import 'package:dio/dio.dart';
import 'package:ipfs_app/utils/local_data.dart';

class MyHttp {
  static Dio dio = Dio();
  static String testHash = "QmYgCkNQcu8NCTZAKo9ZeKpHGm8cpuQQvtHTRZedPD5Thw";
  static String testUri = "https://www.guohao.icu";

  static Future getDownloadInfo(String uri, String hash) async {
    Response response = await dio.post(uri + '/api/v0/object/stat?arg=' + hash);
    print(response);
  }

  static Future downloadFile(String uri, String hash) async {
    Response response = await dio.download(
        uri + '/api/v0/object?arg=' + hash, DataUtil.appDocPath + "\\file",
        onReceiveProgress: (received, total) {
      print(received / total);
    });
  }
}
