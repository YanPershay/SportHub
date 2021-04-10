import 'package:SportHub_client/entities/user.dart';

class AdminPost {
  String title;
  String text;
  int duration;
  int complexity;
  String imageUrl;
  String dateCreated;
  bool isUpdated;
  int categoryId;
  User user;

  AdminPost(
      {this.title,
      this.text,
      this.duration,
      this.complexity,
      this.imageUrl,
      this.dateCreated,
      this.isUpdated,
      this.categoryId,
      this.user});

  AdminPost.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    duration = json['duration'];
    complexity = json['complexity'];
    imageUrl = json['imageUrl'];
    dateCreated = json['dateCreated'];
    isUpdated = json['isUpdated'];
    categoryId = json['categoryId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['duration'] = this.duration;
    data['complexity'] = this.complexity;
    data['imageUrl'] = this.imageUrl;
    data['dateCreated'] = this.dateCreated;
    data['isUpdated'] = this.isUpdated;
    data['categoryId'] = this.categoryId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
