import 'package:SportHub_client/utils/user_notification.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  var actions = ["Subscribed to you", "Liked your photo"];

  List<UserNotification> notifications = [
    UserNotification(
      avatar: "assets/profile.jpg",
      name: "yan_pershay",
      action: "Subscribed to you",
      date: "5 min",
      icon: Icon(Icons.add, color: Colors.blue, size: 40),
    ),
    UserNotification(
        avatar: "assets/profile.jpg",
        name: "yan_pershay",
        action: "Liked your photo",
        date: "1 month",
        postPicture: "assets/running.jpg")
  ];

  Widget actionSwitch(String action, UserNotification notification) {
    if (action == actions[0]) {
      return IconButton(icon: notification.icon, onPressed: () => {});
    } else {
      return Image(
        image: AssetImage(notification.postPicture),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }

  Widget notificationTemplate(UserNotification notification) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(notification.avatar)),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            notification.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(notification.action),
                      ],
                    ),
                    Text(notification.date),
                  ],
                ),
                SizedBox(
                  width: 7,
                ),
                actionSwitch(notification.action, notification),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          )),
      body: Column(
        children: notifications.map((e) => notificationTemplate(e)).toList(),
      ),
    );
  }
}
