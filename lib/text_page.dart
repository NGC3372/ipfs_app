import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TextPage extends StatelessWidget {
  final Map args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    String filepath = args['path'];
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
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) async {
            String contentWeb = await File(filepath).readAsString();
            await controller.loadUrl(Uri.dataFromString(contentWeb,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString());
          },
        ));
  }
}
