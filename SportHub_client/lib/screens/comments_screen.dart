import 'package:SportHub_client/entities/comment.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/comment_item.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;
  final String postUserId;

  CommentsScreen({Key key, @required this.postId, @required this.postUserId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = new TextEditingController();
  List<Comment> comments = new List<Comment>();

  Future<void> getComments() async {
    try {
      var response = await Dio()
          .get(ApiEndpoints.getCommentsGET + widget.postId.toString());
      comments =
          (response.data as List).map((x) => Comment.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendComment() async {
    try {
      if (commentController.text == "") {
        Dialogs.showMyDialog(context, "Error", "Please, enter comment.");
      } else {
        Comment comment = new Comment(
            userId: SharedPrefs.userId,
            text: commentController.text,
            dateCreated: DateTime.now().toString(),
            isUpdated: false,
            postId: widget.postId);
        var response =
            await Dio().post(ApiEndpoints.commentPOST, data: comment);
        comments.add(comment);
        setState(() {
          showComments();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget showComments() {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) => CommentItem(
                comment: comments[index],
                userPostId: widget.postUserId,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: true,
        child: FutureBuilder(
            future: Future.wait([getComments()]),
            builder: (context, snapshot) {
              return Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    elevation: 0,
                    title: Text(
                      "Comments",
                      style: GoogleFonts.workSans(
                        fontStyle: FontStyle.normal,
                        fontSize: 25.r,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) => CommentItem(
                                    comment: comments[index],
                                    userPostId: widget.postUserId,
                                  )),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: TextFormField(
                          controller: commentController,
                          decoration:
                              InputDecoration(hintText: "Write a comment..."),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.send, color: Colors.black),
                          onPressed: () {
                            sendComment();
                            setState(() {
                              commentController.text = "";
                              showComments();
                            });
                          },
                        ),
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
