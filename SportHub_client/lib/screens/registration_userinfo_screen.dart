import 'package:flutter/material.dart';

class RegistrationUserInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationUserInfoScreenState();
  }
}

class RegistrationUserInfoScreenState
    extends State<RegistrationUserInfoScreen> {
  String firstName = '';
  String lastName = '';
  DateTime dateOfBirth = DateTime.now();
  String sportLevel = '';
  double height = 0;
  double weight = 0;
  String about = '';
  String motivation = '';

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Form(
            child: Column(
          children: <Widget>[
            firstNameField(),
            lastNameField(),
            dateOfBirthField(),
            sportLevelDropdown(),
            heightField(),
            weightField(),
            aboutField(),
            motivationField()
          ],
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

  Widget dateOfBirthField() {
    return TextFormField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            labelText: 'Date of birth', hintText: 'Happy birthday'),
        onSaved: (String value) {
          dateOfBirth = DateTime.parse(value);
        });
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
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: 'Weight', hintText: 'Your weight'),
        onSaved: (String value) {
          height = double.parse(value);
        });
  }

  Widget weightField() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: 'Height', hintText: 'Your height'),
        onSaved: (String value) {
          weight = double.parse(value);
        });
  }

  Widget aboutField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'About me', hintText: 'Tell about you if you want.'),
        onSaved: (String value) {
          about = value;
        });
  }

  Widget motivationField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Motivation', hintText: 'Tell us what you want.'),
        onSaved: (String value) {
          motivation = value;
        });
  }
}
