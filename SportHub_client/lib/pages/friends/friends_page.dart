import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/entities/utilsEntities/my_subs_helper.dart';
import 'package:SportHub_client/entities/utilsEntities/subs_helper.dart';
import 'package:SportHub_client/pages/friends/subscribers_widget.dart';
import 'package:SportHub_client/pages/user_profile_page.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  TextEditingController searchController = new TextEditingController();
  List<User> searchResult = new List<User>();

  Future<void> searchUser() async {
    searchResult.clear();
    try {
      var response =
          await Dio().get(ApiEndpoints.searchUsersGET + searchController.text);
      searchResult =
          (response.data as List).map((x) => User.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  Container listTile() {
    return Container(
      height: (searchResult.length * 72).toDouble(),
      child: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: searchResult[index].userInfo.avatarUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(searchResult[index].username),
            subtitle: Text(searchResult[index].userInfo.sportLevel),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                            userId: searchResult[index].guidId,
                          )));
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getMySubscribes(), getSubscribers()]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Wait");
          } else {
            return Scaffold(
              appBar: AppBar(
                  bottom: PreferredSize(
                      child: Container(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                      preferredSize: Size.fromHeight(1.0)),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text(
                    "Friends",
                    style: TextStyle(color: Colors.black),
                  )),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: TextFormField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(hintText: "Search..."),
                        onChanged: (term) {
                          searchUser();
                          setState(() {
                            listTile();
                          });
                        }),
                  ),
                  if (searchResult != null) listTile(),
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: PageView(
                        controller: controller,
                        children: <Widget>[
                          SubscribersWidget(
                            title: "Subscribers",
                            subscribes: subscribers,
                          ),
                          SubscribersWidget(
                            title: "My subscribes",
                            subscribes: mySubscribes,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
