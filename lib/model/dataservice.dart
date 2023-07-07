import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:untitled/model/story_moels.dart';

class DataService{
  Future<List<StoryModel>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/story_data.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    List<StoryModel> storyModel = jsonData.map((json) => StoryModel.fromJson(json)).toList();
    return storyModel;
  }
}