import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/utils/local_data.dart';

class MyListTitle extends StatelessWidget {
  final int index;
  MyListTitle(this.index) {
    print(index);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Get.isDarkMode ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ]),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: DataUtil.setFileType(
                  Get.find<ControlHome>().downloadedInfo[index].type),
              title:
                  Text(Get.find<ControlHome>().downloadedInfo[index].fileName),
              subtitle:
                  Text(Get.find<ControlHome>().downloadedInfo[index].hash),
              trailing:
                  Text(Get.find<ControlHome>().downloadedInfo[index].date),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
                child: Obx(() {
                  return Visibility(
                      visible: !Get.find<ControlHome>()
                          .downloadedInfo[index]
                          .done
                          .value,
                      child: SizedBox(
                        height: 7.0,
                        child: LinearProgressIndicator(
                          value: Get.find<ControlHome>()
                              .downloadedInfo[index]
                              .progress
                              .value,
                        ),
                      ));
                }))
          ],
        ),
      ),
      onTap: () {
        String hash = Get.find<ControlHome>().downloadedInfo[index].hash;
        String filePath = DataUtil.appDocPath + "$hash";
        print(filePath);
        switch (Get.find<ControlHome>().downloadedInfo[index].type) {
          case 'text/html':
            Get.toNamed('textPage', arguments: {'path': filePath});
            break;
          case 'audio':
            Get.toNamed('videoPage', arguments: {'path': filePath});
            break;
          case 'video':
            Get.toNamed('videoPage', arguments: {'path': filePath});
            break;
          case 'picture':
            Get.toNamed('picturePage', arguments: {'path': filePath});
            break;
        }
      },
      onLongPress: () {
        showSetDialog();
      },
    );
  }

  void showSetDialog() {
    Get.dialog(SimpleDialog(
      children: [
        SimpleDialogOption(
          child: Text(
            '修改信息',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            Get.offNamed('changeFileInfoPage', arguments: {'index': index});
          },
        ),
        Divider(),
        SimpleDialogOption(
          child: Text(
            '删除',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            Get.find<ControlHome>().deleteFile(index);
            Get.back();
          },
        ),
      ],
    ));
  }
}
