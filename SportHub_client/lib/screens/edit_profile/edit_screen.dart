import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/screens/edit_profile/edit_account_screen.dart';
import 'package:SportHub_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:SportHub_client/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatelessWidget {
  final User user;

  const EditScreen({Key key, @required this.user}) : super(key: key);

  clearSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Edit profile",
            style: TextStyle(color: Colors.white),
          )),
      body: Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.person),
                title: new Text('Edit account'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditAccountScreen(
                                user: user,
                              )));
                }),
            new ListTile(
              leading: new Icon(Icons.photo_camera),
              title: new Text('Edit profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              userInfo: user.userInfo,
                            )));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('Sign out'),
              onTap: () {
                clearSharedPrefs();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
