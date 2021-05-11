import 'package:SportHub_client/entities/comment.dart';
import 'package:SportHub_client/pages/user_profile_page.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;
  final String userPostId;

  CommentItem({Key key, @required this.comment, @required this.userPostId});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isCommentDeleted = false;

  Future<void> deleteComment() async {
    //Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      var response = await Dio().delete(ApiEndpoints.deleteCommentDELETE,
          data: {"id": widget.comment.id});
      if (response.statusCode == 200) {
        isCommentDeleted = true;
        //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return isCommentDeleted
        ? Container()
        : Card(
            child: Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage(
                                      userId: widget.comment.userId,
                                    )));
                      },
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: widget.comment.user.userInfo.avatarUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 45.0,
                            height: 45.0,
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
                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundImage: AssetImage("assets/icon.jpg"),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.black,
                            radius: 20.r,
                          ),
                        ),
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
                              widget.comment.user.username,
                              style: GoogleFonts.workSans(
                                fontStyle: FontStyle.normal,
                                fontSize: 15.r,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 300,
                              child: Text(
                                widget.comment.text,
                                style: GoogleFonts.workSans(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.r,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              width: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd.MM.yyyy kk:mm').format(
                                        DateTime.parse(
                                            widget.comment.dateCreated)),
                                    style: GoogleFonts.workSans(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.r,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                  widget.comment.userId == SharedPrefs.userId ||
                                          SharedPrefs.userId ==
                                              widget.userPostId
                                      ? GestureDetector(
                                          onTap: () {
                                            deleteComment();
                                          },
                                          child: Text(
                                            "Delete",
                                            style: GoogleFonts.workSans(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 15.r,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                        )
                                      : Text("")
                                ],
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
