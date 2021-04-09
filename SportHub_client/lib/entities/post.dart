class Post {
  int id;
  String text;
  String imageUrl;
  String dateCreated;
  bool isUpdated;
  String userId;

  Post(
      {this.id,
      this.text,
      this.imageUrl,
      this.dateCreated,
      this.isUpdated,
      this.userId});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    dateCreated = json['dateCreated'];
    isUpdated = json['isUpdated'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['imageUrl'] = this.imageUrl;
    data['dateCreated'] = this.dateCreated;
    data['isUpdated'] = this.isUpdated;
    data['userId'] = this.userId;
    return data;
  }
}
