import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyTextFeild extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  String hintText;

  MyTextFeild({this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Get.isDarkMode ? Colors.grey.shade600 : Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          hintText: 'uri',
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Colors.grey,
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }

  get textValue {
    return controller.text;
  }

  set textValue(String value) {
    controller.text = value;
    controller.selection =
        TextSelection(baseOffset: value.length, extentOffset: value.length);
  }
}
