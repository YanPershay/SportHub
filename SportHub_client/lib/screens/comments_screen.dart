import 'package:SportHub_client/entities/comment.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/comment_item.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;

  CommentsScreen({Key key, @required this.postId});

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
      Comment comment = new Comment(
          userId: SharedPrefs.userId,
          text: commentController.text,
          dateCreated: DateTime.now().toString(),
          isUpdated: false,
          postId: widget.postId);
      var response = await Dio().post(ApiEndpoints.commentPOST, data: comment);
      comments.add(comment);
    } catch (e) {
      print(e);
    }
  }

  Widget showComments() {
    return Container(
      height: 650,
      child: ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) =>
              CommentItem(comment: comments[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getComments()]),
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Comments"),
                backgroundColor: Colors.black,
              ),
              body: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              showComments(),
                              Divider(),
                              ListTile(
                                title: TextFormField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      hintText: "Write a comment..."),
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
                          ),
                        )));
              }));
        });
  }
}
