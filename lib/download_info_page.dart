import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/beans/download_info.dart';

import 'controllers/home_contro.dart';

// ignore: must_be_immutable
class DownloadInfoPage extends StatelessWidget {
  RxString selectValue = RxString(null);
  TextEditingController controller = TextEditingController();
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
                child: Text(Get.arguments['hash']),
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
                child: Text(Get.arguments['date']),
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
                child: Text(Get.arguments['fileSize'].toString() + 'b'),
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
            ],
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {},
                child: Text('Download'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void download() {
    Icon type = Icon(Icons.file_copy);
    switch (selectValue.value) {
      case 'text/html':
        type = Icon(Icons.web);
        break;
      case 'audio':
        type = Icon(Icons.audiotrack);
        break;
      case 'video':
        type = Icon(Icons.video_call);
        break;
      case 'picture':
        type = Icon(Icons.picture_in_picture);
        break;
    }
    DownloadInfo bean = DownloadInfo(
        controller.text, Get.arguments['date'], Get.arguments['date'], type);
    ;
  }
}
