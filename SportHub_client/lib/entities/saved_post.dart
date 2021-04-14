class SavedPost {
  int id;
  String userId;
  int postId;

  SavedPost({this.id, this.userId, this.postId});

  SavedPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    return data;
  }
}
