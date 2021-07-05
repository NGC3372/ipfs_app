import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/home_page.dart';
import 'package:ipfs_app/widgets/my_ListTitle.dart';

import 'beans/download_info.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  RxList<DownloadInfo> searchedList = RxList<DownloadInfo>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: TextField(
          controller: searchController,
          autofocus: true,
          onChanged: (value) {
            search(value);
          },
          decoration: InputDecoration(
            border: null,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              searchController.text = '';
            },
            icon: Icon(Icons.clear),
            color: Colors.black,
          )
        ],
      ),
      body: Container(
          color: Colors.grey,
          child: Obx(
            () => ListView.builder(
              itemCount: searchedList.length,
              itemBuilder: (context, index) {
                return MyListTitle(index);
              },
            ),
          )),
    );
  }

  void search(String searchContent) {
    List<DownloadInfo> tempList = [];
    if (searchContent != '') {
      for (var temp in Get.find<ControlHome>().downloadedInfo) {
        if (temp.fileName.contains(searchContent)) tempList.add(temp);
      }
    }
    searchedList.addAll(tempList);
  }
}
