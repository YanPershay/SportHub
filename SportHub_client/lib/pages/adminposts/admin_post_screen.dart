import 'package:SportHub_client/entities/admin_post.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:SportHub_client/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

class AdminPostScreen extends StatefulWidget {
  final AdminPost adminPost;

  AdminPostScreen({@required this.adminPost});

  @override
  State<StatefulWidget> createState() {
    return AdminPostScreenState();
  }
}

class AdminPostScreenState extends State<AdminPostScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> deleteTrainerPost() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      var deleteResponse = await Dio().delete(
          ApiEndpoints.deleteTrainPostDELETE,
          data: {"id": widget.adminPost.id});
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (deleteResponse.statusCode == 200) {
        Toast.show("Successfully deleted", context);
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      print(e);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        deleteTrainerPost();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Really?"),
      content: Text("Are you sure you want to delete this post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 12, bottom: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth * 0.80,
                                  child: Text(
                                    widget.adminPost.title,
                                    style: TextStyle(
                                        fontSize: 30.r,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.8)),
                                    softWrap: true,
                                  ),
                                ),
                                IconButton(
                                    iconSize: 40,
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                            Text(
                              DateFormat('dd.MM.yyyy kk:mm').format(
                                  DateTime.parse(widget.adminPost.dateCreated)),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Text("by " + widget.adminPost.user.username)
                          ],
                        ),
                      ]),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.adminPost.imageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    widget.adminPost.text,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SharedPrefs.isAdmin
                    ? CupertinoButton(
                        color: Colors.grey[900],
                        child: Text("Delete"),
                        onPressed: () {
                          showAlertDialog(context);
                        },
                      )
                    : Text(""),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
