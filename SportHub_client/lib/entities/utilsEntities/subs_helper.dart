import 'package:SportHub_client/entities/user.dart';

class SubsHelper {
  User subscriber;

  SubsHelper({this.subscriber});

  SubsHelper.fromJson(Map<String, dynamic> json) {
    subscriber = json['subscriber'] != null
        ? new User.fromJson(json['subscriber'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriber != null) {
      data['subscriber'] = this.subscriber.toJson();
    }
    return data;
  }
}
