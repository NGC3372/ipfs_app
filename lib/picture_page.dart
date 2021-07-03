import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PicturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Get.parameters['path']);
    return Scaffold(
      appBar: AppBar(
        title: Text('picturePage'),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Image.file(
          File(Get.arguments['path']),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
