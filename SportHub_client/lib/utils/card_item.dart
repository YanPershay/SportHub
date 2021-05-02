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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItem extends StatefulWidget {
  final Post post;
  final UserInfo userInfo;

  final List<SavedPost> savedPosts;

  const CardItem(
      {Key key,
      @required this.post,
      @required this.userInfo,
      @required this.savedPosts})
      : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  //bool isLikePressed = false;
  int likesCount;

  List<Like> likes = [];

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
      widget.savedPosts.add(SavedPost.fromJson(response.data));
    } catch (e) {
      print(e);
    }
  }

  Like likeToDelete;
  bool isLikePressed = false;
  Future<void> deleteLike() async {
    for (var like in likes) {
      if (like.userId == SharedPrefs.userId && like.postId == widget.post.id) {
        likeToDelete = like;
      }
    }
    try {
      var response =
          await Dio().delete(ApiEndpoints.deleteLikeDELETE, data: likeToDelete);
      if (response.statusCode == 200) {
        isLikePressed = false;
        likes.clear();
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  bool isSavedPressed = false;
  SavedPost savedPost;
  Future<void> deleteSavedPost() async {
    for (var post in widget.savedPosts) {
      if (post.postId == widget.post.id) {
        savedPost = post;
      }
    }
    try {
      var response = await Dio()
          .delete(ApiEndpoints.deleteSavedPostDELETE, data: savedPost);
      if (response.statusCode == 200) {
        isSavedPressed = false;
        widget.savedPosts.clear();
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  Widget likeIcon() {
    for (var like in likes) {
      if (like.userId == SharedPrefs.userId) {
        isLikePressed = true;
      }
    }
    return IconButton(
      iconSize: 30.r,
      icon: (isLikePressed)
          ? Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : Icon(Icons.favorite_border, color: Colors.black),
      onPressed: () {
        isLikePressed ? deleteLike() : likePost();
        setState(() {
          isLikePressed ? isLikePressed = false : isLikePressed = true;
          isLikePressed ? likesCount += 1 : likesCount -= 1;
        });
      },
    );
  }

  Widget savedPostIcon() {
    for (var savedPost in widget.savedPosts) {
      if (savedPost.postId == widget.post.id) {
        isSavedPressed = true;
      }
    }
    return IconButton(
      iconSize: 30.r,
      icon: setIcon(),
      onPressed: () {
        isSavedPressed ? deleteSavedPost() : savePost();
        setState(() {
          isSavedPressed ? isSavedPressed = false : isSavedPressed = true;
        });
      },
    );
  }

  Widget setIcon() {
    return Icon(
        (isSavedPressed) ? Icons.bookmark : Icons.bookmark_border_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          height: 475.r,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CachedNetworkImage(
                  imageUrl: widget.userInfo.avatarUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: 14.r),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      widget.post.text,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ]),
              SizedBox(height: 14),
              Row(
                children: <Widget>[
                  SizedBox(width: 5),
                  Row(
                    children: <Widget>[likeIcon(), Text(likesCount.toString())],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        iconSize: 30.r,
                        icon: Icon(Icons.comment_rounded),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CommentsScreen(postId: widget.post.id)));
                        },
                      ),
                      Text(widget.post.comments.length.toString())
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  savedPostIcon()
                ],
              ),
              Divider(),
            ],
          ),
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.white,
                blurRadius: 50.0,
              ),
            ],
          ),
        ));
  }
}
