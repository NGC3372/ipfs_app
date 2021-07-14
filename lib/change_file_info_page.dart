import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/beans/download_info.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/widgets/my_button.dart';

class ChangeFileInfoPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final RxBool filenameContent = RxBool(false);
  final RxBool fileTypeContent = RxBool(false);
  final RxString selectValue = RxString(null);
  final int index = Get.arguments['index'];
  final TextStyle textStyleTtile = TextStyle(
      fontSize: 15,
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold);
  final TextStyle textStyleContent = TextStyle(
      fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    var dataBean = Get.find<ControlHome>().downloadedInfo[index];
    controller.text = dataBean.fileName;
    selectValue.value = dataBean.type;

    return Scaffold(
      appBar: AppBar(
        title: Text('changeFileInfoPage_Title'.tr),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Hash',
                  style: textStyleTtile,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    dataBean.hash,
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
                  'changeFileInfoPage_date'.tr,
                  style: textStyleTtile,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  dataBean.date,
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
                  'changeFileInfoPage_fileSize'.tr,
                  style: textStyleTtile,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '${dataBean.fileSize.toString()}b',
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
                  'changeFileInfoPage_fileName'.tr,
                  style: textStyleTtile,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
              )),
              Obx(
                () => Visibility(
                  visible: filenameContent.value,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'changeFileInfoPage_ContentNull'.tr,
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
                      hint: Text('changeFileInfoPage_fileType_hint'.tr),
                      value: selectValue.value,
                      items: [
                        DropdownMenuItem(
                          child:
                              Text('changeFileInfoPage_fileType_text/html'.tr),
                          value: 'text/html',
                        ),
                        DropdownMenuItem(
                          child: Text('changeFileInfoPage_fileType_audio'.tr),
                          value: 'audio',
                        ),
                        DropdownMenuItem(
                          child: Text('changeFileInfoPage_fileType_video'.tr),
                          value: 'video',
                        ),
                        DropdownMenuItem(
                          child: Text('changeFileInfoPage_fileType_picture'.tr),
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
                      'changeFileInfoPage_ContentNull'.tr,
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
                submit();
              },
              text: 'changeFileInfoPage_Button'.tr,
            ),
          ),
        ],
      ),
    );
  }

  void submit() {
    var dataBean = Get.find<ControlHome>().downloadedInfo[index];
    var newDataBean = DownloadInfo(controller.text, dataBean.hash,
        dataBean.date, selectValue.value, dataBean.fileSize);
    if (controller.text == '')
      filenameContent.value = true;
    else {
      newDataBean.done.value = true;
      Get.find<ControlHome>().changeFileInfo(index, newDataBean);
      Get.back();
    }
  }
}
