import 'package:SportHub_client/entities/user.dart';

class Comment {
  int id;
  String text;
  String dateCreated;
  bool isUpdated;
  String userId;
  int postId;
  User user;

  Comment(
      {this.id,
      this.text,
      this.dateCreated,
      this.isUpdated,
      this.userId,
      this.postId,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    dateCreated = json['dateCreated'];
    isUpdated = json['isUpdated'];
    userId = json['userId'];
    postId = json['postId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['dateCreated'] = this.dateCreated;
    data['isUpdated'] = this.isUpdated;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
