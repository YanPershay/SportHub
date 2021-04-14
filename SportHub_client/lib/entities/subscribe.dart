class Subscribe {
  String userId;
  String subscriberId;

  Subscribe({this.userId, this.subscriberId});

  Subscribe.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    subscriberId = json['subscriberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['subscriberId'] = this.subscriberId;
    return data;
  }
}
