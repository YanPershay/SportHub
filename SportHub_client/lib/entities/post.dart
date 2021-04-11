import 'package:SportHub_client/entities/comment.dart';
import 'package:SportHub_client/entities/like.dart';
import 'package:SportHub_client/entities/user.dart';

class Post {
  int id;
  String text;
  String imageUrl;
  String dateCreated;
  bool isUpdated;
  String userId;
  User user;
  List<Like> likes;
  List<Comment> comments;

  Post(
      {this.id,
      this.text,
      this.imageUrl,
      this.dateCreated,
      this.isUpdated,
      this.userId,
      this.user,
      this.likes,
      this.comments});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    dateCreated = json['dateCreated'];
    isUpdated = json['isUpdated'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['likes'] != null) {
      likes = new List<Like>();
      json['likes'].forEach((v) {
        likes.add(new Like.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = new List<Comment>();
      json['comments'].forEach((v) {
        comments.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['imageUrl'] = this.imageUrl;
    data['dateCreated'] = this.dateCreated;
    data['isUpdated'] = this.isUpdated;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
