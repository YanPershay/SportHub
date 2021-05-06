import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/saved_post.dart';
import 'package:SportHub_client/entities/subscribe.dart';
import 'package:SportHub_client/entities/subscriptions.dart';
import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/screens/edit_profile/edit_screen.dart';
import 'package:SportHub_client/screens/saved_posts_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/card_item.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({Key key, @required this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  User user;
  List<Post> userPosts = [];
  bool isSubscribed;
  Subscriptions subscriptions;
  //String username = "";

  Future<void> getUser() async {
    try {
      var response = await Dio().get(ApiEndpoints.userGET + widget.userId);
      user = User.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSubsCount() async {
    try {
      var response = await Dio().get(ApiEndpoints.subsCountGET + widget.userId);
      subscriptions = Subscriptions.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserPosts() async {
    try {
      var response = await Dio().get(ApiEndpoints.userPostsGET + widget.userId);
      userPosts = (response.data as List).map((x) => Post.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> isUserSubscribed() async {
    try {
      var response = await Dio().get(ApiEndpoints.isSubscribed + widget.userId);
      isSubscribed = response.data;
    } catch (e) {
      print(e);
    }
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> subscribeToUser() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      var response = await Dio().post(ApiEndpoints.subscribeToUserPOST,
          data: new Subscribe(
              userId: widget.userId, subscriberId: SharedPrefs.userId));
    } catch (e) {
      print(e);
    } finally {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    }
  }

  List<SavedPost> savedPosts = [];
  Future<void> getSavedPosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.savedPostsListGET + SharedPrefs.userId);
      savedPosts =
          (response.data as List).map((x) => SavedPost.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unsubscribeUser() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      var response =
          await Dio().get(ApiEndpoints.getSubscribeObjGET + widget.userId);
      if (response.statusCode == 200) {
        var deleteResponse = await Dio()
            .delete(ApiEndpoints.unsubscribeDELETE, data: response.data);
      }
    } catch (e) {
      print(e);
    } finally {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    //getUserInfo();
  }

  Widget userButtons() {
    if (widget.userId == SharedPrefs.userId) {
      return Row(
        children: [
          Expanded(child: Container()),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  gradient: LinearGradient(
                      colors: [Color(0xff66D0EB5), Color(0xff4059F1)],
                      begin: Alignment.bottomRight,
                      end: Alignment.centerLeft)),
              child: Center(child: Icon(Icons.settings, color: Colors.white)),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditScreen(user: user)));
            },
          ),
          VerticalDivider(),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  gradient: LinearGradient(
                      colors: [Color(0xff66D0EB5), Color(0xff4059F1)],
                      begin: Alignment.bottomRight,
                      end: Alignment.centerLeft)),
              child: Center(child: Icon(Icons.bookmark, color: Colors.white)),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SavedPostsScreen()));
            },
          ),
          VerticalDivider()
        ],
      );
    } else {
      return FutureBuilder(
          future: Future.wait([isUserSubscribed()]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              if (isSubscribed) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        height: 35.r,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(33.r)),
                            gradient: LinearGradient(
                                colors: [Color(0xff66D0EB5), Color(0xff4059F1)],
                                begin: Alignment.bottomRight,
                                end: Alignment.centerLeft)),
                        child: Center(
                          child: Text('Unsubscribe',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.r,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      onTap: () {
                        unsubscribeUser();
                        setState(() {
                          userButtons();
                        });
                      },
                    ),
                    Container(
                      width: 10.r,
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        height: 35.r,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(33.r)),
                            gradient: LinearGradient(
                                colors: [Color(0xff66D0EB5), Color(0xff4059F1)],
                                begin: Alignment.bottomRight,
                                end: Alignment.centerLeft)),
                        child: Center(
                          child: Text('Subscribe',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.r,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      onTap: () {
                        subscribeToUser();
                        setState(() {
                          userButtons();
                        });
                      },
                    ),
                    Container(
                      width: 10.r,
                    )
                  ],
                );
              }
            }
          });
    }
  }

  var posts;
//получаем юзер инфо, посты при открытии профиля, добавляем все в бд. при sign out бд очистится
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait(
            [getUserPosts(), getSavedPosts(), getUser(), getSubsCount()]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.grey[900],
                    title: Text(
                      SharedPrefs.username,
                      style: TextStyle(color: Colors.white),
                    )),
                backgroundColor: Colors.grey[900],
                body: Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                ));
          } else {
            userPosts.isEmpty || user == null
                ? Center(
                    child: Text("Sorry, something went wrong :(",
                        style: TextStyle(color: Colors.white)))
                : posts = List.generate(userPosts.length, (index) {
                    return CardItem(
                      post: userPosts[index],
                      userInfo: user.userInfo,
                      savedPosts: savedPosts,
                    );
                  });

            return user == null
                ? Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.grey[900],
                        title: Text(
                          SharedPrefs.username,
                          style: TextStyle(color: Colors.white),
                        )),
                    backgroundColor: Colors.grey[900],
                    body: Center(
                        child: Text("Sorry, something went wrong :(",
                            style: TextStyle(color: Colors.white))))
                : Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.grey[900],
                        title: Text(
                          user.username,
                          style: TextStyle(color: Colors.white),
                        )),
                    backgroundColor: Colors.grey[900],
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 35.r,
                                ),
                                CachedNetworkImage(
                                  imageUrl: user.userInfo.avatarUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 100.r,
                                    height: 100.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/icon.jpg"),
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.black,
                                    radius: 45.r,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 38),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          user.userInfo.firstName +
                                              " " +
                                              user.userInfo.lastName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30.r,
                                              color: Colors.white),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 15.r,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                    user.userInfo.country +
                                                        ', ' +
                                                        user.userInfo.city,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.r,
                                                        wordSpacing: 4)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.r),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    subscriptions
                                                        .subscribersCount
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25.r)),
                                                Text(
                                                  'followers',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ]),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.r),
                                          child: Container(
                                            height: 45.r,
                                            width: 1.r,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    subscriptions
                                                        .mySubscribesCount
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25.r)),
                                                Text(
                                                  'following',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ]),
                                        ),
                                        Expanded(child: Container())
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(child: userButtons()),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.r, horizontal: 1.r),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.r))),
                                child: Text(
                                  (user.userInfo.sportLevel != ''
                                          ? (user.userInfo.sportLevel +
                                              " level \n")
                                          : '') +
                                      (user.userInfo.aboutMe != ''
                                          ? (user.userInfo.aboutMe + "\n")
                                          : '') +
                                      (user.userInfo.motivation != ''
                                          ? ("My motivation is " +
                                              user.userInfo.motivation +
                                              "\n")
                                          : '') +
                                      (user.userInfo.height != 0
                                          ? (user.userInfo.height.toString() +
                                              " sm., ")
                                          : '') +
                                      (user.userInfo.weight != 0
                                          ? (user.userInfo.weight.toString() +
                                              " kg. \n")
                                          : '') +
                                      (user.userInfo.dateOfBirth != null
                                          ? ("Born " +
                                              user.userInfo.dateOfBirth)
                                          : ''),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.karla(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20.r,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(34),
                                      bottom: Radius.circular(34))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10.r),
                                    child: Center(
                                      child: Text(
                                        'Publications',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.r),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: posts,
                                  ),
                                  Container(
                                    height: 40.r,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
          }
        } //),
        );
  }
}
