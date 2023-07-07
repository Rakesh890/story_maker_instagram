import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {


  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  bool isInitVideoPlayer =false;
  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }
  
  initVideoPlayer() async {
    try{
      controller = VideoPlayerController.networkUrl(Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"));
      await controller.initialize().then((value) {
            setState(() {
              isInitVideoPlayer = true;
              debugPrint(isInitVideoPlayer.toString())
;           });
          });
      controller.play();
    }catch(err){
      isInitVideoPlayer = false;
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(isInitVideoPlayer == true){
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 20),
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ),
      );
    }else{
      return const CupertinoActivityIndicator();
    }

  }
}