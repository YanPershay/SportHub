import 'package:SportHub_client/entities/user.dart';

class MySubsHelper {
  User user;

  MySubsHelper({this.user});

  MySubsHelper.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
