import 'package:SportHub_client/pages/adminposts/trains_page.dart';
import 'package:SportHub_client/pages/feed_page.dart';
import 'package:SportHub_client/pages/friends/friends_page.dart';
import 'package:SportHub_client/pages/user_profile_page.dart';
import 'package:SportHub_client/screens/newpost/add_newpost_screen.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavScreen extends StatefulWidget {
  BottomNavScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNavScreenState();
  }
}

class BottomNavScreenState extends State<BottomNavScreen> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      setState(() => prefs = sharedPrefs);
    });
  }

  var currentPage = 3;

  var pages = [
    FeedPage(),
    FriendsPage(),
    NewPostScreen(),
    TrainsPage(),
    UserProfilePage(
      userId: SharedPrefs.userId,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentPage),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Домой',
              backgroundColor: Colors.grey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Друзья',
              backgroundColor: Colors.grey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Создать',
              backgroundColor: Colors.grey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new_sharp),
              label: 'Блог',
              backgroundColor: Colors.grey[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
              backgroundColor: Colors.grey[900]),
        ],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.grey[900],
        currentIndex: currentPage,
        fixedColor: Colors.white,
        onTap: (int index) {
          setState(() {
            if (index == 2)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPostScreen()));
            else
              currentPage = index;
          });
        },
      ),
    );
  }
}
