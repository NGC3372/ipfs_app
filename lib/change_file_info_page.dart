import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/beans/download_info.dart';
import 'package:ipfs_app/controllers/home_contro.dart';

class ChangeFileInfoPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final RxBool filenameContent = RxBool(false);
  final RxBool fileTypeContent = RxBool(false);
  final RxString selectValue = RxString(null);
  final int index = Get.arguments['index'];

  @override
  Widget build(BuildContext context) {
    var dataBean = Get.find<ControlHome>().downloadedInfo[index];
    controller.text = dataBean.fileName;
    selectValue.value = dataBean.type;

    return Scaffold(
      appBar: AppBar(
        title: Text('downloadInfoPage_title'.tr),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Hash'),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    dataBean.date,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('downloadInfoPage_date'.tr),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(dataBean.date),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('downloadInfoPage_fileName'.tr),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  child: TextField(
                    controller: controller,
                  ),
                  width: 80,
                ),
              ),
              Obx(
                () => Visibility(
                  visible: filenameContent.value,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'downloadInfoPage_ContentNull'.tr,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('downloadInfoPage_fileType'.tr),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text('downloadInfoPage_fileType_hint'.tr),
                      value: selectValue.value,
                      items: [
                        DropdownMenuItem(
                          child: Text('downloadInfoPage_fileType_text/html'.tr),
                          value: 'text/html',
                        ),
                        DropdownMenuItem(
                          child: Text('downloadInfoPage_fileType_audio'.tr),
                          value: 'audio',
                        ),
                        DropdownMenuItem(
                          child: Text('downloadInfoPage_fileType_video'.tr),
                          value: 'video',
                        ),
                        DropdownMenuItem(
                          child: Text('downloadInfoPage_fileType_picture'.tr),
                          value: 'picture',
                        ),
                      ],
                      onChanged: (value) {
                        selectValue.value = value;
                        print(value);
                      },
                    ),
                  )),
              Obx(
                () => Visibility(
                  visible: fileTypeContent.value,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'downloadInfoPage_ContentNull'.tr,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  submit();
                },
                child: Text('changeFileInfoPage_Button'.tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit() {
    var dataBean = Get.find<ControlHome>().downloadedInfo[index];
    var newDataBean = DownloadInfo(
        controller.text, dataBean.hash, dataBean.date, selectValue.value);
    newDataBean.done.value = true;
    Get.find<ControlHome>().changeFileInfo(index, newDataBean);
    Get.back();
  }
}
