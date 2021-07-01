import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RxString selectValue = RxString(null);
    return Scaffold(
      appBar: AppBar(
        title: Text('downloadInfoPage'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('hash'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('XXXXXXXXXXXXX'),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('date'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('2020-02-10'),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('fileName'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  child: TextField(),
                  width: 80,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('type'),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text('choose one'),
                      value: selectValue.value,
                      items: [
                        DropdownMenuItem(
                          child: Text('text/html'),
                          value: 'text/html',
                        ),
                        DropdownMenuItem(
                          child: Text('audio'),
                          value: 'audio',
                        ),
                        DropdownMenuItem(
                          child: Text('video'),
                          value: 'video',
                        ),
                        DropdownMenuItem(
                          child: Text('picture'),
                          value: 'picture',
                        ),
                      ],
                      onChanged: (value) {
                        selectValue.value = value;
                        print(value);
                      },
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
