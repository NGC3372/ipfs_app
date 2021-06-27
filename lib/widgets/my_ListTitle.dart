import 'package:flutter/material.dart';

class MyListTitle extends StatelessWidget {
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
            leading: Icon(Icons.music_note),
            title: Text('title'),
            subtitle: Text('hash:XXXXXXX'),
            trailing: Text('2020-04-05-17:30'),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
              child: SizedBox(
                height: 7.0,
                child: LinearProgressIndicator(
                  value: 0.3,
                ),
              ))
        ],
      ),
    );
  }
}
