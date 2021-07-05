import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class AudioPage extends StatelessWidget {
  AudioPlayer player = AudioPlayer();
  RxBool isPlaying = RxBool(false);

  @override
  Widget build(BuildContext context) {
    Future init = initAudio();
    var labelLocation = TimeLabelLocation.below;
    var labelType = TimeLabelType.totalTime;
    return Scaffold(
      appBar: AppBar(
        title: Text('audioPage'),
      ),
      body: Container(
        child: FutureBuilder(
            future: init,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(player.position);
                print(player.duration);
                return ProgressBar(
                  progress: Duration.zero,
                  buffered: Duration.zero,
                  total: player.duration,
                  timeLabelLocation: labelLocation,
                  timeLabelType: labelType,
                  onSeek: (duration) {
                    player.seek(duration);
                  },
                );
              } else
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Obx(() => Icon(isPlaying.value ? Icons.pause : Icons.play_arrow)),
        onPressed: () {
          isPlaying.value ? player.pause() : player.play();
          isPlaying.value = !isPlaying.value;
        },
      ),
    );
  }

  Future initAudio() async {
    String filePath = Get.arguments['path'];
    await player.setFilePath(filePath);
  }
}
