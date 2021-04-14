class SavedPost {
  String userId;
  int postId;

  SavedPost({this.userId, this.postId});

  SavedPost.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    return data;
  }
}
