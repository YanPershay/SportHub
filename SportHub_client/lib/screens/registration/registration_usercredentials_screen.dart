import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/screens/registration/registration_userinfo_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
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

  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length == 0 ||
                            value[0] == "." ||
                            value[0] == ",") {
                          return 'Username should start from letters';
                        }
                        return null;
                      },
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
                          : "Please, enter correct email.",
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
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
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
                            padding: const EdgeInsets.only(top: 18.0),
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
                    SizedBox(height: 10.0),
                    TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                          labelText: 'CONFIRM PASSWORD ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      obscureText: true,
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.black,
                          color: Colors.black,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              validateFields();
                            },
                            child: Center(
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Text('BACK',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ]));
  }

  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    return form.validate();
  }

  Future<void> validateFields() async {
    try {
      if (validateAndSave()) {
        if (usernameController.text.length == 0 ||
            emailController.text.length == 0 ||
            passwordController.text.length == 0) {
          _showDialog("Empty fields", "Please, fill empty fields.");
        } else {
          if (passwordController.text.length < 8) {
            _showDialog("Weak password",
                "Password should contain more than 7 symbols.");
          } else {
            Dialogs.showLoadingDialog(context, _keyLoader);
            var response = await Dio()
                .get(ApiEndpoints.isUsernameBusyGET + usernameController.text);
            if (response.statusCode == 200) {
              bool isUsernameBusy = response.data.toString() == "true";
              if (isUsernameBusy) {
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
                _showDialog("Busy", "Please, select other username.");
              } else {
                if (passwordController.text == confirmPasswordController.text) {
                  Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                      .pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationUserInfoScreen(
                                userCredentials: setUser(),
                              )));
                } else {
                  Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                      .pop();
                  _showDialog("Error", "Password not confirmed.");
                }
              }
            } else {
              _showDialog("Error", "Troubles with internet.");
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
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
              child: new Text("Закрыть"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: "Email", hintText: "user@gmail.com"),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "Please enter a valid email",
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password", hintText: "Enter your password"),
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Confirm password",
          hintText: "Confirm your your password"),
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

  User setUser() {
    User userCredentials = new User(
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text);
    return userCredentials;
  }
}
