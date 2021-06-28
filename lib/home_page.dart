import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:ipfs_app/widgets/my_ListTitle.dart';

import 'controllers/home_contro.dart';

class HomePage extends GetView<ControlHome> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return MyListTitle();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onDownloadFile();
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
