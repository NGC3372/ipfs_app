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
        title: Text('downloadInfoPage'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('hash'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(args['hash']),
              ),
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
                child: Text('fileSize'),
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
                child: Text('fileName'),
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
                      '该项不能为空',
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
                child: Text('type'),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text('choose one'),
                      value: selectValue.value,
                      items: [
                        DropdownMenuItem(
                          child: Text('text/html'),
                          value: 'text/html',
                        ),
                        DropdownMenuItem(
                          child: Text('audio'),
                          value: 'audio',
                        ),
                        DropdownMenuItem(
                          child: Text('video'),
                          value: 'video',
                        ),
                        DropdownMenuItem(
                          child: Text('picture'),
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
                      '该项不能为空',
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
                child: Text('Download'),
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
