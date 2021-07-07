import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/beans/download_info.dart';

import 'controllers/home_contro.dart';

// ignore: must_be_immutable
class DownloadInfoPage extends StatelessWidget {
  RxString selectValue = RxString(null);
  TextEditingController controller = TextEditingController();
  Map args = Get.arguments;
  RxBool filenameContent = RxBool(false);
  RxBool fileTypeContent = RxBool(false);

  @override
  Widget build(BuildContext context) {
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
                child: Text('downloadInfoPage_date'.tr),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    args['hash'],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('date'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(args['date']),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('downloadInfoPage_fileSize'.tr),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(args['fileSize'].toString() + 'b'),
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
                  download();
                },
                child: Text('downloadInfoPage_Button'.tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void download() {
    fileTypeContent.value = false;
    filenameContent.value = false;
    if (selectValue.value == null) fileTypeContent.value = true;
    if (controller.text == '') filenameContent.value = true;
    if (selectValue.value != null &&
        controller.text != null &&
        controller.text != '') {
      DownloadInfo bean = DownloadInfo(
          controller.text, args['hash'], args['date'], selectValue.value);
      Get.find<ControlHome>().onDownloadFile(args['fileSize'], bean);
      Get.back();
    }
  }
}
