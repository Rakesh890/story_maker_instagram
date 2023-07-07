import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/HomeController.dart';
import 'package:untitled/screens/video_player_widget.dart';
import 'package:video_player/video_player.dart';

import '../model/story_moels.dart';

class StoryView extends StatelessWidget {
  final StoryModel storyItems;
  final HomeController controller;

  const StoryView(
      {Key? key, required this.storyItems, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Stack(
          children:[
            GestureDetector(
              onTap: () => controller.nextStory(storyItems),
              child: Obx(() {
                final storyIndex = controller.storiesIndex;
                final storiesItem = storyItems.stories![storyIndex];
                if(storiesItem.type == "video")  {
                  // return FutureBuilder(
                  //   initialData: controller.initVideoPlayer(storiesItem.url!),
                  //   builder: (context, snapshot){
                  //   if(snapshot.hasData){
                  //       return VideoPlayer(controller.videoPlayerController);
                  //   }else {
                  //     return const CircularProgressIndicator();
                  //   }
                  // },);

                  return VideoPlayerWidget();
                }
                else if(storiesItem.type == "image"){
                  return Image.network(storiesItem.url.toString());
                }
                return const SizedBox();
              }),
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: Text(storyItems.username.toString(),style: TextStyle(color: Colors.white,fontSize: 18.0),),
              ),
            )
          ]
        ),
      ),
    );
  }
}
