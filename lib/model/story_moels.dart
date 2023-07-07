class StoryModel {
  final String? username;
  final List<Stories>? stories;

  StoryModel({
    this.username,
    this.stories,
  });

  StoryModel.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String?,
        stories = (json['stories'] as List?)?.map((dynamic e) => Stories.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'username' : username,
    'stories' : stories?.map((e) => e.toJson()).toList()
  };
}

class Stories {
  final String? title;
  final String? url;
  final String? type;

  Stories({
    this.title,
    this.url,
    this.type,
  });

  Stories.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        url = json['url'] as String?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'title' : title,
    'url' : url,
    'type' : type
  };
}