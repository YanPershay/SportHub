import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  String firstName = '';
  String lastName = '';
  int age = 0;
  String username = '';
  String sportLevel = '';
  double height = 0;
  double weight = 0;
  String about = '';
  String email = '';
  String password = '';

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Form(
            child: Column(
          children: <Widget>[firstNameField(), lastNameField(), ageField()],
        )));
  }

  Widget firstNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'First name', hintText: 'Enter your name...'),
      onSaved: (String value) {
        firstName = value;
      },
    );
  }

  Widget lastNameField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: 'Last name', hintText: "Enter your surname..."),
        onSaved: (String value) {
          firstName = value;
        });
  }

  Widget ageField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Age', hintText: 'Age y.o.'),
        onSaved: (String value) {
          age = int.parse(value);
        });
  }
}
