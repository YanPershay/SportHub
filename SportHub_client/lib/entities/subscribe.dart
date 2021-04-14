class Subscribe {
  int id;
  String userId;
  String subscriberId;

  Subscribe({this.id, this.userId, this.subscriberId});

  Subscribe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    subscriberId = json['subscriberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['subscriberId'] = this.subscriberId;
    return data;
  }
}
