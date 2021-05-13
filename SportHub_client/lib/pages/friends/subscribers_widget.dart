import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../user_profile_page.dart';

class SubscribersWidget extends StatefulWidget {
  final List subscribes;

  SubscribersWidget({
    Key key,
    this.title,
    @required this.subscribes,
  }) : super(key: key);

  final String title;

  @override
  SubscribersWidgetState createState() => new SubscribersWidgetState();
}

class SubscribersWidgetState extends State<SubscribersWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.subscribes == null
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.white,
                title: Text(
                  widget.title,
                  style: TextStyle(color: Colors.black),
                )),
            backgroundColor: Colors.white,
            body: Center(
                child: Text("Sorry, something went wrong :(",
                    style: TextStyle(color: Colors.black))))
        : Scaffold(
            appBar: new AppBar(
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.black,
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(1.0)),
              elevation: 0,
              toolbarHeight: 40,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  widget.title == "Мои подписки"
                      ? Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30.r,
                        )
                      : Text(""),
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
              actions: <Widget>[
                widget.title == "Подписчики"
                    ? Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 30.r,
                      )
                    : Text("")
              ],
            ),
            body: Column(children: <Widget>[
              Expanded(
                  child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.subscribes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: widget.subscribes[index].userInfo.avatarUrl,
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
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundImage: AssetImage("assets/icon.jpg"),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.black,
                          radius: 20.r,
                        ),
                      ),
                      title: Text(widget.subscribes[index].username),
                      subtitle:
                          Text(widget.subscribes[index].userInfo.sportLevel),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage(
                                      userId: widget.subscribes[index].guidId,
                                    )));
                      });
                },
              ))
            ]),
          );
  }
}
