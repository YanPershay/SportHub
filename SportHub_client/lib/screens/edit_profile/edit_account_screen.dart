import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/entities/utilsEntities/auth_response.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> updateAccount() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    setUser();
    try {
      if (usernameController.text != SharedPrefs.username) {
        var response = await Dio()
            .get(ApiEndpoints.isUsernameBusyGET + usernameController.text);
        if (response.statusCode == 200) {
          bool isUsernameBusy = response.data.toString() == "true";
          if (isUsernameBusy) {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            _showDialog("Username busy", "Please, choose another username");
          }
        }
      } else {
        var responseAuth = await Dio().post(ApiEndpoints.checkPass, data: {
          "username": SharedPrefs.username,
          "password": oldPasswordController.text
        });
        var response = await Dio().put(ApiEndpoints.userPUT, data: newUser);
        if (response.statusCode == 200) {
          var newToken = await Dio().post(ApiEndpoints.checkPass, data: {
            "username": SharedPrefs.username,
            "password": newPasswordController.text
          });
          var authResponse = AuthResponse.fromJson(newToken.data);

          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("username", usernameController.text);
          prefs.setString("token", authResponse.token);
          print(authResponse.token);
          print(responseAuth.data["token"]);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavScreen()),
              (Route<dynamic> route) => false);

          _showDialog("Success", "Account data was successful updated!");
        } else {
          _showDialog("Error", "Something went wrong, please, try again.");
        }
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      _showDialog("Incorrect password", "Old password incorrect.");
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[900],
            title: Text(
              "Edit account",
              style: GoogleFonts.workSans(
                  fontStyle: FontStyle.normal,
                  fontSize: 25.r,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
        body: Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => EmailValidator.validate(value)
                    ? null
                    : "Please enter a valid email",
                decoration: InputDecoration(
                  labelText: 'EMAIL ',
                  labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                    labelText: 'PASSWORD ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                    labelText: 'NEW PASSWORD ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.black,
                    color: Colors.black,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        updateAccount();
                      },
                      child: Center(
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 20.0)
            ])));
    // body: new Container(
    //     margin: EdgeInsets.all(16),
    //     child: Column(children: <Widget>[
    //       emailField(),
    //       usernameField(),
    //       oldPasswordField(),
    //       newPasswordField(),
    //       Padding(
    //           padding: EdgeInsets.symmetric(vertical: 16.0),
    //           child: ElevatedButton(
    //             onPressed: () {
    //               //не забыть закинуть обновленное имя в шаред префс но только в случае успешного обновления
    //               updateAccount();
    //             },
    //             child: Text('Update'),
    //             style: ElevatedButton.styleFrom(
    //                 primary: Colors.black,
    //                 padding:
    //                     EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    //                 textStyle: TextStyle(
    //                     fontSize: 30, fontWeight: FontWeight.bold)),
    //           )),
    //     ])));
  }

  Future<void> validateFields() async {
    //Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      if (usernameController.text != SharedPrefs.username) {
        var response = await Dio()
            .get(ApiEndpoints.isUsernameBusyGET + usernameController.text);
        if (response.statusCode == 200) {
          bool isUsernameBusy = response.data.toString() == "true";
          if (isUsernameBusy) {
            //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            _showDialog("Username busy", "Please, choose another username");
          } else {
            //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            await updateAccount();
          }
        } else {
          //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          _showDialog("Error", "Troubles with internet.");
        }
      }
    } catch (e) {
      print(e);
    }
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
