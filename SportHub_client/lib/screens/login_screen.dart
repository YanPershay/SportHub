import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/screens/registration/registration_usercredentials_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: EdgeInsets.only(top: 20),
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              emailField(),
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

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email adress', hintText: 'example@gmail.com'),
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      //obscureText: true,
      decoration: InputDecoration(labelText: 'Password', hintText: 'Password'),
      onSaved: (String value) {
        password = value;
      },
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()));
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
}
