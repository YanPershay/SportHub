import 'package:SportHub_client/entities/comment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  CommentItem({Key key, @required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: comment.user.userInfo.avatarUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundImage: AssetImage("assets/icon.jpg"),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.black,
                    radius: 20.r,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.user.username,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            comment.text,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            DateFormat('dd.MM.yyyy kk:mm')
                                .format(DateTime.parse(comment.dateCreated)),
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
