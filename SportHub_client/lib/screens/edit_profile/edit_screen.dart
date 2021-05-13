import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/screens/edit_profile/edit_account_screen.dart';
import 'package:SportHub_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:SportHub_client/screens/login_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:SportHub_client/utils/system_padding.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditScreen extends StatefulWidget {
  final User user;

  const EditScreen({Key key, @required this.user}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  clearSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> deleteAccount(String password) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      var deleteResponse = await Dio().delete(ApiEndpoints.deleteAccountDELETE,
          data: {"username": SharedPrefs.username, "password": password});
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (deleteResponse.statusCode == 200) {
        Toast.show("Successfully deleted", context);
        Navigator.of(context).pop();
        clearSharedPrefs();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      print(e);
    }
  }

  TextEditingController controller = new TextEditingController();
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter your password to confirm action'),
            content: TextField(
              controller: controller,
              textInputAction: TextInputAction.go,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: new Text('Delete my account'),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteAccount(controller.text);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Настройки",
            style: GoogleFonts.workSans(
                fontStyle: FontStyle.normal,
                fontSize: 25.r,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )),
      body: Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.person),
                title: new Text('Редактировать аккаунт'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditAccountScreen(
                                user: widget.user,
                              )));
                }),
            new ListTile(
              leading: new Icon(Icons.photo_camera),
              title: new Text('Редактировать профиль'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              userInfo: widget.user.userInfo,
                            )));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('Выйти'),
              onTap: () {
                clearSharedPrefs();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
            // new ListTile(
            //   leading: new Icon(Icons.warning, color: Colors.red),
            //   title: new Text('Delete your account',
            //       style: TextStyle(color: Colors.red)),
            //   onTap: () {
            //     //clearSharedPrefs();
            //     _displayDialog(context);
            //     //Navigator.of(context).pushAndRemoveUntil(
            //     //    MaterialPageRoute(builder: (context) => LoginScreen()),
            //     //  (Route<dynamic> route) => false);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
