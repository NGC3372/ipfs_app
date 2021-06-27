import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:ipfs_app/controllers/home_contro.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page2'),
      ),
      body: IconButton(
        onPressed: () {
          ControlHome contro = Get.find();
          print(contro.a);
          contro.setA("hahahha");
        },
        icon: Icon(Icons.ac_unit),
      ),
    );
  }
}
