import 'dart:convert';
import 'dart:io';

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

  @override
  void onInit() async {
    await DataUtil.getInstance();
    readDownloadList();
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
    String path = DataUtil.appDocPath + '\downloadList.json';
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
      await file.writeAsString(jsonEncode([]));
    }
    List result = jsonDecode(await file.readAsString());

    return result;
  }

  void writeDownloadList() {
    String path = DataUtil.appDocPath + '\downloadList.json';
    File file = File(path);
    List downloadList = [];
    for (DownloadInfo tempBean in downloadedInfo) {
      downloadList.add(tempBean.toMap());
    }
    file.writeAsString(jsonEncode(downloadList));
  }

//下载文件
  void onDownloadFile(int fileSize, DownloadInfo bean) async {
    downloadedInfo.add(bean);
    await MyHttp.downloadFile(MyHttp.testUri, MyHttp.testHash, fileSize,
        downloadedInfo.length - 1, bean.fileName);
    writeDownloadList();
  }
}
