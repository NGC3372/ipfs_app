import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/beans/download_info.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/utils/local_data.dart';

// ignore: must_be_immutable
class MyListTitle extends StatelessWidget {
  final int index;
  DownloadInfo dataBean;

  MyListTitle(this.index) {
    dataBean = Get.find<ControlHome>().downloadedInfo[index];
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
                leading: DataUtil.setFileType(dataBean.type),
                title: Row(
                  children: [
                    Text(
                      dataBean.fileName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'listItem_date'.tr + ': ${dataBean.date}',
                          style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 13),
                        ),
                      ),
                    ))
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hash:' + dataBean.hash,
                        style: TextStyle(fontSize: 12)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                          'listItem_fileSize'.tr +
                              ': ' +
                              DataUtil.formatFileSize(dataBean.fileSize),
                          style: TextStyle(fontSize: 14)),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
                child: Obx(() {
                  return Visibility(
                      visible: !dataBean.done.value,
                      child: SizedBox(
                        height: 7.0,
                        child: LinearProgressIndicator(
                          value: dataBean.progress.value,
                        ),
                      ));
                }))
          ],
        ),
      ),
      onTap: () {
        String hash = dataBean.hash;
        String filePath = DataUtil.appDocPath + "$hash";
        Map args = {
          'path': filePath,
          'fileName': dataBean.fileName,
        };
        switch (dataBean.type) {
          case 'text/html':
            Get.toNamed('textPage', arguments: args);
            break;
          case 'media':
            Get.toNamed('mediaPage', arguments: args);
            break;
          case 'picture':
            Get.toNamed('picturePage', arguments: args);
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
            'listItem_dialog_changeFileInfo'.tr,
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            Get.offNamed('changeFileInfoPage', arguments: {'index': index});
          },
        ),
        Divider(),
        SimpleDialogOption(
          child: Text(
            'listItem_dialog_deleteFile'.tr,
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
