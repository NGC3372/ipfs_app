import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/beans/download_info.dart';
import 'package:ipfs_app/widgets/my_button.dart';

import 'controllers/home_contro.dart';

// ignore: must_be_immutable
class DownloadInfoPage extends StatelessWidget {
  RxString selectValue = RxString(null);
  TextEditingController controller = TextEditingController();
  Map args = Get.arguments;
  RxBool filenameContent = RxBool(false);
  RxBool fileTypeContent = RxBool(false);
  TextStyle textStyleTtile = TextStyle(
      fontSize: 15,
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold);
  TextStyle textStyleContent = TextStyle(
      fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal);

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
                child: Text(
                  'hash',
                  style: textStyleTtile,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    args['hash'],
                    style: textStyleContent,
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'downloadInfoPage_date'.tr,
                  style: textStyleTtile,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  args['date'],
                  style: textStyleContent,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'downloadInfoPage_fileSize'.tr,
                  style: textStyleTtile,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  args['fileSize'].toString() + 'b',
                  style: textStyleContent,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'downloadInfoPage_fileName'.tr,
                  style: textStyleTtile,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                      },
                    )),
                  ),
                  width: 120,
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
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'downloadInfoPage_fileType'.tr,
                  style: textStyleTtile,
                ),
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
          Divider(),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: MyTextButton(
              tap: () {
                download();
              },
              text: 'downloadInfoPage_Button'.tr,
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
