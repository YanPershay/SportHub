import 'package:flutter/material.dart';

class UserNotification {
  String name;
  String avatar;
  String action;
  Icon icon;
  String postPicture;
  String date;

  UserNotification(
      {this.avatar,
      this.name,
      this.action,
      this.date,
      this.icon,
      this.postPicture});
}
