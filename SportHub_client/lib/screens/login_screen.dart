import 'dart:convert';

import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/utilsEntities/auth_response.dart';
import 'package:SportHub_client/entities/utilsEntities/user_credentials.dart';
import 'package:SportHub_client/screens/registration/registration_usercredentials_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 50.0),
                    child: Text('Sport',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 195.0, 0.0, 0.0),
                    child: Text('hub',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(145.0, 195.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: 'ИМЯ ПОЛЬЗОВАТЕЛЯ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'ПАРОЛЬ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        suffixIcon: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            _toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                    // SizedBox(height: 5.0),
                    // Container(
                    //   alignment: Alignment(1.0, 0.0),
                    //   padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    //   child: InkWell(
                    //     child: Text(
                    //       'Forgot Password',
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: 'Montserrat',
                    //           decoration: TextDecoration.underline),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.black,
                        color: Colors.black,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            authorization();
                          },
                          child: Center(
                            child: Text(
                              'ВОЙТИ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Нет аккаунта в SportHub?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegistrationUserCredentialsScreen()));
                  },
                  child: Text(
                    'Регистрация',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> authorization() async {
    if (usernameController.text.length == 0 ||
        passwordController.text.length == 0) {
      Dialogs.showMyDialog(
          context, "Пусто", "Пожалуйста, заполните пустые поля.");
    } else {
      Dialogs.showLoadingDialog(context, _keyLoader);
      UserCredentials userCredentials = new UserCredentials(
          username: usernameController.text, password: passwordController.text);

      final authResponse = await http.post(
          Uri.https(ApiEndpoints.host, ApiEndpoints.authenticationPOST),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userCredentials.toJson()));

      if (authResponse.statusCode == 200) {
        var authUser = AuthResponse.fromJson(jsonDecode(authResponse.body));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', authUser.guidId);
        prefs.setString('username', authUser.username);
        prefs.setString('token', authUser.token);
        prefs.setBool('isAdmin', authUser.isAdmin);

        SharedPrefs.username = authUser.username;
        SharedPrefs.userId = authUser.guidId;
        SharedPrefs.token = authUser.token;
        SharedPrefs.isAdmin = authUser.isAdmin;

        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavScreen()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Dialogs.showMyDialog(context, "Неверно", "Логин или пароль неверны.");
      }
    }
  }
}
