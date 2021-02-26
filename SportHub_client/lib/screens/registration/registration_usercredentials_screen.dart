import 'package:SportHub_client/screens/registration/registration_userinfo_screen.dart';
import 'package:flutter/material.dart';

class RegistrationUserCredentialsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistartionUserCredentialsScreenState();
  }
}

class RegistartionUserCredentialsScreenState
    extends State<RegistrationUserCredentialsScreen> {
  String username = '';
  String email = '';
  String password = '';

  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            margin: EdgeInsets.all(16),
            child: Column(children: <Widget>[
              emailField(),
              passwordField(),
              usernameField(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegistrationUserInfoScreen()));
                    },
                    child: Text('Next'),
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
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: "Email", hintText: "user@gmail.com"),
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password", hintText: "Enter your password"),
        onSaved: (String value) {
          password = value;
        });
  }

  Widget usernameField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Username", hintText: "Enter your username"),
        onSaved: (String value) {
          username = value;
        });
  }
}
