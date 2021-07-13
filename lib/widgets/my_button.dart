import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyTextButton extends StatelessWidget {
  String text = '';
  Function tap = () {};

  MyTextButton({this.tap, this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black : Colors.red,
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      child: TextButton(
        onPressed: () {
          tap();
        },
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              text.tr,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
