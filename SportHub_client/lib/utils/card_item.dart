import 'package:SportHub_client/entities/like.dart';
import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/saved_post.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/pages/user_profile_page.dart';
import 'package:SportHub_client/screens/comments_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardItem extends StatefulWidget {
  final Post post;
  final UserInfo userInfo;

  const CardItem({Key key, @required this.post, @required this.userInfo})
      : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  //bool isLikePressed = false;
  int likesCount;
  List<SavedPost> savedPosts;
  List<Like> likes = new List<Like>();

  @override
  void initState() {
    super.initState();
    likesCount = widget.post.likes.length;
    likes = widget.post.likes;
  }

  Future<void> likePost() async {
    try {
      Like like = new Like(postId: widget.post.id, userId: SharedPrefs.userId);
      var response = await Dio().post(ApiEndpoints.likePOST, data: like);
      likes.add(Like.fromJson(response.data));
    } catch (e) {
      print(e);
    }
  }

  Future<void> savePost() async {
    try {
      var response = await Dio().post(ApiEndpoints.savePostPOST,
          data: new SavedPost(
              postId: widget.post.id, userId: SharedPrefs.userId));
    } catch (e) {
      print(e);
    }
  }

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

  Like likeToDelete;
  Future<void> deleteLike() async {
    for (var like in likes) {
      if (like.userId == SharedPrefs.userId && like.postId == widget.post.id) {
        likeToDelete = like;
      }
    }
    try {
      var response =
          await Dio().delete(ApiEndpoints.deleteLikeDELETE, data: likeToDelete);
    } catch (e) {
      print(e);
    }
  }

  bool isLikePressed = false;
  Widget likeIcon() {
    for (var like in likes) {
      if (like.userId == SharedPrefs.userId) {
        isLikePressed = true;
        //likesCount = widget.post.likes.length;
        // return IconButton(
        //   icon: Icon(Icons.thumb_up_alt_outlined, color: Colors.red),
        //   onPressed: () {
        //     deleteLike();
        //     setState(() {
        //       isLikePressed = false;
        //       likesCount -= 1;
        //     });
        //   },
        // );
      }
    }
    return IconButton(
      icon: Icon(Icons.thumb_up_alt_outlined,
          color: (isLikePressed) ? Colors.red : Colors.grey),
      onPressed: () {
        isLikePressed ? deleteLike() : likePost();
        setState(() {
          isLikePressed ? isLikePressed = false : isLikePressed = true;
          isLikePressed ? likesCount += 1 : likesCount -= 1;
          likes.clear();
        });
      },
    );
  }

  bool isSavedPressed = false;
  Widget savedPostIcon() {
    for (var savedPost in savedPosts) {
      if (savedPost.postId == widget.post.id) {
        return IconButton(
          icon: Icon(Icons.bookmark),
          onPressed: () {
            setState(() {
              //likesCount -= 1;
            });
          },
        );
      }
    }
    return IconButton(
      icon: ((isSavedPressed)
          ? Icon(Icons.bookmark)
          : Icon(Icons.bookmark_border_outlined)),
      onPressed: () {
        savePost();
        setState(() {
          isSavedPressed = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getSavedPosts()]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Wait");
          } else {
            return Card(
                child: Container(
                    height: 350,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: widget.userInfo.avatarUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 40.0,
                              height: 40.0,
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
                          title: Text(widget.post.user.username),
                          subtitle: Text(widget.userInfo.sportLevel),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfilePage(
                                          userId: widget.post.userId,
                                        )));
                          },
                        ),
                        Expanded(
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: widget.post.imageUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 10),
                              Text(
                                widget.post.text,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ]),
                        SizedBox(height: 14),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 5),
                            Row(
                              children: <Widget>[
                                likeIcon(),
                                Text(likesCount.toString())
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.comment_rounded),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommentsScreen(
                                                    postId: widget.post.id)));
                                  },
                                ),
                                Text(widget.post.comments.length.toString())
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(width: 200),
                                savedPostIcon(),
                                SizedBox(width: 8)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
                    )));
          }
        });
  }
}
