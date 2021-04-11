import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/screens/saved_posts_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/card_item.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  UserInfo userInfo;
  List<Post> userPosts;

  Future<void> getUserInfo() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.userInfoGET + SharedPrefs.userId);
      userInfo = UserInfo.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserPosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.userPostsGET + SharedPrefs.userId);
      userPosts = (response.data as List).map((x) => Post.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //getUserInfo();
  }

//получаем юзер инфо, посты при открытии профиля, добавляем все в бд. при sign out бд очистится
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getUserInfo(), getUserPosts()]),
        builder: (context, snapshot) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    SharedPrefs.username,
                    style: TextStyle(color: Colors.white),
                  )),
              backgroundColor: Colors.black,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 28, top: 7),
                        child: CachedNetworkImage(
                          imageUrl: userInfo.avatarUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userInfo.firstName + userInfo.lastName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        userInfo.country + ', ' + userInfo.city,
                                        style: TextStyle(
                                            color: Colors.white,
                                            wordSpacing: 4)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 38.0, left: 38, top: 15, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('17k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              Text(
                                'followers',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                        Container(
                          color: Colors.white,
                          width: 0.2,
                          height: 22,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('387',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              Text(
                                'following',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                        Container(
                          color: Colors.white,
                          width: 0.2,
                          height: 22,
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 18, right: 18, top: 8, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33)),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff66D0EB5),
                                      Color(0xff4059F1)
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.centerLeft)),
                            child: Text('Edit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 18, right: 18, top: 8, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(33)),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff66D0EB5),
                                      Color(0xff4059F1)
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.centerLeft)),
                            child: Text('Saved',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SavedPostsScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Level: ' + userInfo.sportLevel,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            child: Text(
                              "About: " + userInfo.aboutMe,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            child: Text(
                              "Motivation: " + userInfo.motivation,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            child: Text(
                              'Height: ' +
                                  userInfo.height.toString() +
                                  ', Weight: ' +
                                  userInfo.weight.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            child: Text(
                              'Birthday: ' + userInfo.dateOfBirth,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(34))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 33, right: 25, left: 25),
                            child: Text(
                              'Publications',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 33),
                            ),
                          ),
                          Container(
                            height: 279,
                            child: ListView.builder(
                                itemCount: userPosts.length,
                                itemBuilder: (context, index) => CardItem(
                                      post: userPosts[index],
                                      userInfo: userInfo,
                                    )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
