import 'package:dio/dio.dart';

class MyHttp {
  static Dio dio = Dio();

  static void getDownloadInfo(String uri, String hash) async {
    var response = await dio.post(uri + '/api/v0/object/stat?arg=' + hash);
    print(response);
  }
}
