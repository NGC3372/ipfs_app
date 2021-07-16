import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PicturePage extends StatelessWidget {
  final Map args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print(args['path']);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo, size: 30, color: Colors.white),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(args['fileName']),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: PhotoView(
            imageProvider: FileImage(
          File(Get.arguments['path']),
        )),
      ),
      /* Image.file(
          File(Get.arguments['path']),
          fit: BoxFit.cover,
        ),*/
    );
  }
}
