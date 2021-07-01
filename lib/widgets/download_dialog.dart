import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/controllers/download_dialog_controller.dart';
import 'package:ipfs_app/utils/http.dart';

// ignore: must_be_immutable
class MyDownloadDialog extends StatelessWidget {
  final TextEditingController hashControler = TextEditingController();
  var searching = false.obs;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('检索文件'),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              enabled: true,
              controller: hashControler,
            ),
            TextButton(
              onPressed: () {
                searchFile();
              },
              child: Text('检索'),
            ),
            Visibility(
              child: CircularProgressIndicator(),
              visible: false,
            )
          ],
        ),
      ],
    );
  }

  Future searchFile() async {
    var response =
        await MyHttp.getDownloadInfo(MyHttp.testUri, MyHttp.testHash);

    if (response != null) {
      String hash = response.data['Hash'];
      int fileSize = response.data['CumulativeSize'];
      DateTime date = new DateTime.now();
      Get.offNamed('downloadInfoPage', arguments: {
        "hash": hash,
        "fileSize": fileSize,
        "date": date.toString()
      });
    } else {
      Get.snackbar('Ops!', '没找到文件');
    }
  }
}
