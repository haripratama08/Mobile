import 'package:flutter/material.dart';

class KameraUtama extends StatefulWidget {
  @override
  _KameraUtamaState createState() => _KameraUtamaState();
}

class _KameraUtamaState extends State<KameraUtama> {
  // Controller controller;
  @override
  void initState() {
    super.initState();
    // controller = new Controller(
    //   items: [
    //     //
    //     new PlayerItem(
    //       title: 'video 1',
    //       url:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //       // subtitleUrl: "https://wecast.ch/posters/vt.vtt",
    //     ),
    //     new PlayerItem(
    //       startAt: Duration(seconds: 2),
    //       title: 'video 2',
    //       aspectRatio: 16 / 4,
    //       url:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       subtitleUrl: "https://wecast.ch/posters/vtt.vtt",
    //     ),
    //     new PlayerItem(
    //       title: 'video 3',
    //       aspectRatio: 16 / 9,
    //       url:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       subtitleUrl: "https://wecast.ch/posters/vtt.vtt",
    //     ),
    //   ],
    //   autoPlay: true,
    //   errorBuilder: (context, message) {
    //     return new Container(
    //       child: new Text(message),
    //     );
    //   },
    //   // index: 2,
    //   autoInitialize: true,
    //   // isLooping: false,
    //   allowedScreenSleep: false,
    //   // showControls: false,
    //   hasSubtitles: true,
    //   // isLive: true,
    //   // showSeekButtons: false,
    //   // showSkipButtons: false,
    //   // allowFullScreen: false,
    //   fullScreenByDefault: false,
    //   // placeholder: new Container(
    //   //   color: Colors.grey,
    //   // ),
    //   isPlaying: (isPlaying) {
    //     //
    //     // print(isPlaying);
    //   },

    //   playerItem: (playerItem) {
    //     // print('Player title: ' + playerItem.title);
    //     // print('position: ' + playerItem.position.inSeconds.toString());
    //     // print('Duration: ' + playerItem.duration.inSeconds.toString());
    //   },
    //   videosCompleted: (isCompleted) {
    //     print(isCompleted);
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Center(
      child: Text(
        "Fitur dalam pengembangan",
        style: TextStyle(fontFamily: 'Mont', fontSize: 15),
      ),
    )
        // Center(
        //   child: VideoPlayerControls(
        //     controller: controller,
        //   ),
        // )

        );
  }
}
