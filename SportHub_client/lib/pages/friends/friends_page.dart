import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/entities/utilsEntities/my_subs_helper.dart';
import 'package:SportHub_client/entities/utilsEntities/subs_helper.dart';
import 'package:SportHub_client/pages/friends/subscribers_widget.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  @override
  FriendsPageState createState() => FriendsPageState();
}

class FriendsPageState extends State<FriendsPage> {
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<User> mySubscribes;
  List<MySubsHelper> subscribesResponse;

  Future<void> getMySubscribes() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.mySubscribesGET + SharedPrefs.userId);
      subscribesResponse =
          (response.data as List).map((x) => MySubsHelper.fromJson(x)).toList();
      mySubscribes = new List<User>();
      for (var userSubscribe in subscribesResponse) {
        mySubscribes.add(userSubscribe.user);
      }
    } catch (e) {
      print(e);
    }
  }

  List<User> subscribers;
  List<SubsHelper> subscribersResponse;

  Future<void> getSubscribers() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.subscribersGET + SharedPrefs.userId);
      subscribersResponse =
          (response.data as List).map((x) => SubsHelper.fromJson(x)).toList();
      subscribers = new List<User>();
      for (var subscriber in subscribersResponse) {
        subscribers.add(subscriber.subscriber);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getMySubscribes(), getSubscribers()]),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
                bottom: PreferredSize(
                    child: Container(
                      color: Colors.black,
                      height: 1.0,
                    ),
                    preferredSize: Size.fromHeight(1.0)),
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  "Friends",
                  style: TextStyle(color: Colors.black),
                )),
            body: PageView(
              controller: controller,
              children: <Widget>[
                SubscribersWidget(
                  title: "Subscribers",
                  subscribes: subscribers,
                ),
                SubscribersWidget(
                  title: "Subscribes",
                  subscribes: mySubscribes,
                ),
              ],
            ),
          );
        });
  }
}
