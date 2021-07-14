import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';
import 'package:ipfs_app/widgets/my_ListTitle.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  RxList<int> searchedList = RxList<int>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? Colors.grey.shade600 : Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              )),
          title: TextField(
            controller: searchController,
            autofocus: true,
            cursorColor: Colors.black,
            onChanged: (value) {
              search(value);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'search_page_hint'.tr,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                searchController.text = '';
              },
              icon: Icon(Icons.clear),
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )
          ],
        ),
        body: Column(
          children: [
            Divider(),
            Expanded(
              child: Container(
                  child: Obx(
                () => ListView.builder(
                  itemCount: searchedList.length,
                  itemBuilder: (context, index) {
                    return MyListTitle(searchedList[index]);
                  },
                ),
              )),
            )
          ],
        ));
  }

  void search(String searchContent) {
    List<int> tempList = [];
    searchedList.clear();
    if (searchContent != '') {
      for (var temp in Get.find<ControlHome>().downloadedInfo) {
        if (temp.fileName.contains(searchContent)) {
          tempList.add(Get.find<ControlHome>().downloadedInfo.indexOf(temp));
        }
      }
    }

    searchedList.addAll(tempList);
  }
}
