import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipfs_app/controllers/home_contro.dart';

class MyListTitle extends StatelessWidget {
  final int index;
  MyListTitle(this.index) {
    print(index);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Get.find<ControlHome>().downloadedInfo[index].type,
            title: Text(Get.find<ControlHome>().downloadedInfo[index].fileName),
            subtitle: Text(Get.find<ControlHome>().downloadedInfo[index].hash),
            trailing: Text(Get.find<ControlHome>().downloadedInfo[index].date),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
              child: Obx(() {
                print('build');
                return Visibility(
                    visible: Get.find<ControlHome>()
                        .downloadedInfo[index]
                        .done
                        .value,
                    child: SizedBox(
                      height: 7.0,
                      child: LinearProgressIndicator(
                        value: Get.find<ControlHome>()
                            .downloadedInfo[index]
                            .progress
                            .value,
                      ),
                    ));
              }))
        ],
      ),
    );
  }
}
