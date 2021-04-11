import 'package:SportHub_client/entities/comment.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/comment_item.dart';
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
            body: Column(
              children: <Widget>[
                Container(
                  height: 620,
                  child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) =>
                          CommentItem(comment: comments[index])),
                ),
                Divider(),
                ListTile(
                  title: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: "Write a comment..."),
                  ),
                  trailing: OutlinedButton(
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () => {},
                    child: Text(
                      "Post",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
