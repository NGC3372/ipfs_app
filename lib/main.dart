import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: 'home',
    getPages: [GetPage(name: 'home', page: () => HomePage())],
  ));
}
