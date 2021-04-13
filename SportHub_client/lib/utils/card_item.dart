import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/pages/user_profile_page.dart';
import 'package:SportHub_client/screens/comments_screen.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardItem extends StatelessWidget {
  final Post post;
  final UserInfo userInfo;

  const CardItem({Key key, @required this.post, @required this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: 350,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: userInfo.avatarUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(post.user.username),
                  subtitle: Text(userInfo.sportLevel),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfilePage(
                                  userId: post.userId,
                                )));
                  },
                ),
                Expanded(
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text(
                        post.text,
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
                        IconButton(
                          icon: Icon(Icons.thumb_up_alt_outlined),
                          onPressed: () {},
                        ),
                        Text(post.likes.length.toString())
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
                                        CommentsScreen(postId: post.id)));
                          },
                        ),
                        Text(post.comments.length.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(width: 230),
                        Icon(Icons.bookmark),
                        SizedBox(width: 8)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12),
              ],
            )));
  }
}
