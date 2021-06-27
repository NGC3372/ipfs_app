import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ipfs_app/controllers/download_dialog_controller.dart';

class MyDownloadDialog extends StatelessWidget {
  final TextEditingController hashControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GetBuilder(
        init: DialogDownloadController(),
        builder: (controller) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              enabled: true,
              controller: hashControler,
            ),
            TextButton(
              onPressed: () {},
              child: Text('检索'),
            ),
            Visibility(
              child: CircularProgressIndicator(),
              visible: true,
            )
          ],
        ),
      ),
    );
  }
}
