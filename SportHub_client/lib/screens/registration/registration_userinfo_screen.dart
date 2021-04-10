import 'dart:convert';
import 'package:SportHub_client/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:flutter/material.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';

class RegistrationUserInfoScreen extends StatefulWidget {
  final User userCredentials;
  RegistrationUserInfoScreen({Key key, @required this.userCredentials})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistrationUserInfoScreenState();
  }
}

class RegistrationUserInfoScreenState
    extends State<RegistrationUserInfoScreen> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController dateOfBirthController = new TextEditingController();
  TextEditingController sportController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();
  TextEditingController motivationController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();

  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: new Container(
            padding: EdgeInsets.only(top: 20),
            margin: EdgeInsets.all(16),
            child: Column(children: <Widget>[
              firstNameField(),
              lastNameField(),
              dateOfBirthField(),
              sportLevelDropdown(),
              heightField(),
              weightField(),
              aboutField(),
              motivationField(),
              countryField(),
              cityField(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      registrateUser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("Registrate"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  )),
            ])));
  }

  Widget firstNameField() {
    return TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'First name', hintText: 'Enter your name...'),
    );
  }

  Widget lastNameField() {
    return TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Last name', hintText: "Enter your surname..."),
    );
  }

  Widget countryField() {
    return TextFormField(
      controller: countryController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Country', hintText: "Belarus"),
    );
  }

  Widget cityField() {
    return TextFormField(
      controller: cityController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'City', hintText: "Minsk"),
    );
  }

  Widget dateOfBirthField() {
    return TextFormField(
      controller: dateOfBirthController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
          labelText: 'Date of birth', hintText: 'Happy birthday'),
    );
  }

  String dropdownValue = 'Newbie';
  Widget sportLevelDropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      underline: Container(height: 2, color: Colors.black),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Newbie', 'Middle', 'Advanced']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget heightField() {
    return TextFormField(
      controller: heightController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Weight', hintText: 'Your weight'),
    );
  }

  Widget weightField() {
    return TextFormField(
      controller: weightController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Height', hintText: 'Your height'),
    );
  }

  Widget aboutField() {
    return TextFormField(
      controller: aboutController,
      decoration: InputDecoration(
          labelText: 'About me', hintText: 'Tell about you if you want.'),
    );
  }

  Widget motivationField() {
    return TextFormField(
      controller: motivationController,
      decoration: InputDecoration(
          labelText: 'Motivation', hintText: 'Tell us what you want.'),
    );
  }

  UserInfo createUserInfoObj(String userId) {
    return new UserInfo(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        country: countryController.text,
        city: cityController.text,
        dateOfBirth: dateOfBirthController.text,
        sportLevel: dropdownValue,
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        aboutMe: aboutController.text,
        motivation: motivationController.text,
        avatarUrl:
            "https://i.pinimg.com/736x/33/85/f2/3385f2e1ae928f80fda6304ce36c6165--avatar-makeup-film-avatar.jpg",
        userId: userId);
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

  Future<UserInfo> registrateUser() async {
    var userJson = widget.userCredentials.toJson();

    userJson.removeWhere((key, value) => key == null || value == null);
    final userResponse =
        await http.post(Uri.https(ApiEndpoints.host, ApiEndpoints.userPOST),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(userJson));

    if (userResponse.statusCode == 200) {
      var userInfoJson =
          createUserInfoObj(User.fromJson(jsonDecode(userResponse.body)).guidId)
              .toJson();
      final userInfoResponse = await http.post(
          Uri.https(ApiEndpoints.host, ApiEndpoints.userInfoPOST),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userInfoJson));

      if (userInfoResponse.statusCode == 200) {
        _showDialog("Success", "You has been successfully registered!");
        return UserInfo.fromJson(jsonDecode(userInfoResponse.body));
      } else {
        _showDialog("Failed", "You full user registration failed (");
        throw Exception('Failed to create user info');
      }
    } else {
      _showDialog("Failed", "You user creds registration failed (");
      throw Exception('Failed to create user');
    }
  }
}
