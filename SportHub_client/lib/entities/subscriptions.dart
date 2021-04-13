class Subscriptions {
  int subscribersCount;
  int mySubscribesCount;

  Subscriptions({this.subscribersCount, this.mySubscribesCount});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    subscribersCount = json['subscribersCount'];
    mySubscribesCount = json['mySubscribesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscribersCount'] = this.subscribersCount;
    data['mySubscribesCount'] = this.mySubscribesCount;
    return data;
  }
}
