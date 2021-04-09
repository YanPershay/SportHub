import 'dart:convert';

import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/utilsEntities/auth_response.dart';
import 'package:SportHub_client/entities/utilsEntities/user_credentials.dart';
import 'package:SportHub_client/screens/registration/registration_usercredentials_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: EdgeInsets.only(top: 20),
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              usernameField(),
              passwordField(),
              Container(
                margin: EdgeInsets.all(20),
              ),
              loginButton(),
              registrationButton()
            ],
          )),
    );
  }

  Widget usernameField() {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Username', hintText: 'user_name'),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      //obscureText: true,
      decoration: InputDecoration(labelText: 'Password', hintText: 'Password'),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      color: Colors.black,
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        authorization();
      },
    );
  }

  Widget registrationButton() {
    return RaisedButton(
      color: Colors.black,
      child: Text(
        'Registartion',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegistrationUserCredentialsScreen()));
      },
    );
  }

  Future<UserCredentials> authorization() async {
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

      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavScreen()));
    } else {
      throw Exception('Failed to create user');
    }
  }
}
