import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<MediaPage> {
  VideoPlayerController _controller;
  Map args = Get.arguments;
  @override
  void initState() {
    super.initState();
    File file = File(args['path']);
    _controller = VideoPlayerController.file(file)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: _controller,
    );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.movie, size: 30, color: Colors.white),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(args['fileName']),
            )
          ],
        ),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
