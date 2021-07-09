import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/beans/download_info.dart';
import 'package:ipfs_app/utils/http.dart';
import 'package:ipfs_app/utils/local_data.dart';

class ControlHome extends GetxController {
  RxList<DownloadInfo> downloadedInfo = RxList<DownloadInfo>([]);

  @override
  void onInit() async {
    await DataUtil.getInstance();
    DataUtil.initAppSetting();
    List<DownloadInfo> temp = [];
    for (Map tempItem in await readDownloadList()) {
      DownloadInfo tempBean = DownloadInfo(tempItem['fileName'],
          tempItem['hash'], tempItem['date'], tempItem['type']);
      tempBean.done.value = true;
      temp.add(tempBean);
    }
    downloadedInfo.addAll(temp);
    super.onInit();
  }

  Future<List> readDownloadList() async {
    String path = DataUtil.downloadListPath + '/downloadList.json';
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
      await file.writeAsString(jsonEncode([]));
    }
    var downloadDirectory = Directory(DataUtil.appDocPath);
    try {
      bool exists = await file.exists();
      if (!exists) {
        await downloadDirectory.create();
      }
    } catch (e) {
      print(e);
    }
    List result = jsonDecode(await file.readAsString());
    print(result);
    return result;
  }

  void writeDownloadList() {
    String path = DataUtil.downloadListPath + '/downloadList.json';
    File file = File(path);
    List downloadList = [];
    for (DownloadInfo tempBean in downloadedInfo) {
      downloadList.add(tempBean.toMap());
    }
    file.writeAsString(jsonEncode(downloadList));
  }

  void onDownloadFile(int fileSize, DownloadInfo bean) async {
    downloadedInfo.add(bean);
    await MyHttp.downloadFile(
        bean.hash, fileSize, downloadedInfo.length - 1, bean.fileName);
    writeDownloadList();
  }
}
