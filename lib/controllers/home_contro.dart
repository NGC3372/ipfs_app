import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/beans/download_info.dart';
import 'package:ipfs_app/utils/http.dart';
import 'package:ipfs_app/utils/local_data.dart';

class ControlHome extends GetxController {
  var a = "hello9".obs;

  void setA(String s) {
    a.value = s;
  }

  RxList<DownloadInfo> downloadedInfo = RxList<DownloadInfo>([]);
  void download() async {}

  @override
  void onInit() async {
    print('initcontro');
    await DataUtil.getInstance();
    print(DataUtil.appDocPath);
    List<DownloadInfo> temp = [];
    temp.add(DownloadInfo(
        "name1", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
    temp.add(DownloadInfo(
        "name2", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
    temp.add(DownloadInfo(
        "name3", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
    temp.add(DownloadInfo(
        "name4", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
    temp.add(DownloadInfo(
        "name5", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
    temp.add(DownloadInfo(
        "name6", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
    print('oninti');

    downloadedInfo.addAll(temp);
    print(downloadedInfo.length);
    super.onInit();
  }

  void onDownloadFile(int listIndex) async {
    var response =
        (await MyHttp.getDownloadInfo(MyHttp.testUri, MyHttp.testHash));
    int fileSize = response.data['CumulativeSize'];
    await MyHttp.downloadFile(
        MyHttp.testUri, MyHttp.testHash, fileSize, listIndex);
  }

  void testAddInfo() {
    downloadedInfo.add(DownloadInfo(
        "name1", "XXXXXXX", "2021", Icon(Icons.music_note_outlined)));
  }

  void setItemProgress(int index) {
    Get.find<ControlHome>().downloadedInfo[index].progress.value += 0.1;
  }
}
