import 'dart:math';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/model/dataservice.dart';
import 'package:untitled/model/story_moels.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController{



  StoryModel storyModel = StoryModel();
  DataService dataService = DataService();
  RxList<StoryModel> storyDataList = RxList();
  RxDouble degValue = RxDouble(0.0);
  late VideoPlayerController vPlayerController;
  RxBool isInitPlayer = false.obs;
  RxInt storyItemIndex = 0.obs;
  RxInt currentPage = 0.obs;

  VideoPlayerController get videoPlayerController =>   vPlayerController;




  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  Future<void> loadData () async {
   final storyData = await dataService.loadJsonData();
   storyDataList.value = storyData;
  }

  RxList<StoryModel> get userStoryData => storyDataList;

  degreeToRadian(double deg) => deg * pi / 180;


  setInitVideoPlayer(bool bool) {
    isInitPlayer.value = bool;
  }

  bool get isInitVideoPlayer => isInitPlayer.value;

  int get storiesIndex => storyItemIndex.value;

  nextStory(StoryModel storyItems) {
    final lastIndex = (storyItems.stories!.length - 1);
    // if (storiesIndex < lastIndex) {
    //   storyItemIndex.value ++;
    //   debugPrint("last index $lastIndex : Move Index ${storiesIndex}");
    // }
    // else if (storiesIndex != 0 ) {
    // }else{
    //   storyItemIndex.value --;
    //
    // }

    if (storiesIndex < (lastIndex)) {
      storyItemIndex.value ++;
    } else if (storiesIndex == (lastIndex)) {
      storyItemIndex(0);
    }else{
      storyItemIndex.value --;
    }
    debugPrint("Previous $storiesIndex last index $lastIndex ");


  }

  initVideoPlayer(String url) async {
       vPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
       await vPlayerController.initialize();
       if(vPlayerController.value.isInitialized){
         isInitPlayer(true);
       }else{
         isInitPlayer(false);
       }
  }

  loadStory(){
      final storyItem = userStoryData[currentPage.value].stories![storiesIndex];
      if (storyItem.type == "image") {
        // _animController.duration = story.duration;
        // _animController.forward();
      }
        else if(storyItem.type == "video"){
        vPlayerController?.dispose();
        vPlayerController = VideoPlayerController.networkUrl(Uri.parse(storyItem.url!))
          ..initialize().then((_) {
            debugPrint("init");
            if (vPlayerController.value.isInitialized) {
              setInitVideoPlayer(true);
              vPlayerController.value.duration;
              vPlayerController.play();
              // _animController.forward();
            }
          });
      }
      }
      // if (animateToPage) {
      //   _pageController.animateToPage(
      //     _currentIndex,
      //     duration: const Duration(milliseconds: 1),
      //     curve: Curves.easeInOut,
      //   );








  onVideoError(Object? error) {
    setInitVideoPlayer(false);
    debugPrint("Something went wrong here $error");
  }


}