import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/widgets/download_dialog.dart';

import 'package:ipfs_app/widgets/my_ListTitle.dart';

import 'controllers/home_contro.dart';

class HomePage extends GetView<ControlHome> {
  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.a.value)),
        leading: IconButton(
          onPressed: () {
            Get.toNamed("settingsPage");
          },
          icon: Icon(Icons.settings),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.downloadedInfo.length,
          itemBuilder: (context, index) {
            return MyListTitle(controller.downloadedInfo.length - 1 - index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //controller.onDownloadFile(0);
          Get.dialog(MyDownloadDialog());
          // showDialog(
          // context: context, builder: (context) => MyDownloadDialog());
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
