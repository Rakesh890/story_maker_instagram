import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/HomeController.dart';
import 'package:untitled/model/story_moels.dart';
import 'package:untitled/screens/video_player_widget.dart';
import 'package:video_player/video_player.dart';

import 'StoryView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeController homeController = Get.put(HomeController());
  PageController pageController = PageController();
  double currentPage = 0;
  late VideoPlayerController videoPlayerController;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!;
        homeController.storyItemIndex(0);
        homeController.currentPage(currentPage.toInt());
      });
    });
    homeController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          () => PageView.builder(
          controller: pageController,
            itemCount: homeController.storyDataList.length,
            itemBuilder: (context,int index){
              final storyItems = homeController.storyDataList[index];
              if (currentPage.floor() == index) {
                double value = currentPage - index;
                double degValue = homeController.degreeToRadian(value * 90);

                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(degValue),
                  alignment: Alignment.centerRight,
                  child: VideoPlayerWidget(),
                  // StoryView(storyItems: storyItems,controller: homeController,)
                );
              }else if (currentPage.floor() + 1 == index) {
                double value = currentPage - index;
                double degValue = homeController.degreeToRadian(value * 90);

                return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(degValue),
                    alignment: Alignment.centerLeft,
                    child:VideoPlayerWidget(),);
                    // StoryView(storyItems: storyItems, controller: homeController,));
              }
              return VideoPlayerWidget();
                // StoryView(storyItems: storyItems,controller: homeController,);
        }),
      ),
    );
  }





}
