import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccountScreen extends StatefulWidget {
  final User user;

  const EditAccountScreen({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditAccountScreenState();
  }
}

class EditAccountScreenState extends State<EditAccountScreen> {
  String username = '';
  String email = '';
  String password = '';

  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.user.email;
    usernameController.text = widget.user.username;
  }

  Future<void> updateAccount() async {
    setUser();
    try {
      var response = await Dio().put(ApiEndpoints.userPUT, data: newUser);
      if (response.statusCode == 200) {
        _showDialog("Success", "Account data was successful updated!");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("username", usernameController.text);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()));
      } else {
        _showDialog("Error", "Something went wrong, please, try again.");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Edit account",
              style: TextStyle(color: Colors.white),
            )),
        body: new Container(
            margin: EdgeInsets.all(16),
            child: Column(children: <Widget>[
              emailField(),
              usernameField(),
              oldPasswordField(),
              newPasswordField(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      //не забыть закинуть обновленное имя в шаред префс но только в случае успешного обновления
                      updateAccount();
                    },
                    child: Text('Update'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  )),
            ])));
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: "Email", hintText: "user@gmail.com"),
    );
  }

  Widget oldPasswordField() {
    return TextFormField(
      controller: oldPasswordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Old password", hintText: "Enter your old password"),
    );
  }

  Widget newPasswordField() {
    return TextFormField(
      controller: newPasswordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "New password", hintText: "Enter your new password"),
    );
  }

  Widget usernameField() {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Username", hintText: "Enter your username"),
    );
  }

  User newUser;
  User setUser() {
    newUser = new User(
        email: emailController.text,
        username: usernameController.text,
        password: newPasswordController.text,
        guidId: widget.user.guidId);
    return newUser;
  }

  void _showDialog(String title, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
