import 'dart:convert';
import 'dart:io';
import 'package:SportHub_client/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:flutter/material.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  final picker = ImagePicker();
  File _image;
  String avatarUrl;

  Future<void> sendImage() async {
    try {
      if (_image != null) {
        String filename = _image.path.split('/').last;

        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(_image.path, filename: filename),
        });
        var response =
            await Dio().post(ApiEndpoints.imageToBlobPOST, data: formData);
        if (response.statusCode == 200) {
          avatarUrl = response.data.toString();
        } else {
          _showDialog(
              "Error", "Problems with uploading image, please, try again.");
        }
      }
      //return response.data.toString();
    } catch (e) {
      _showDialog("Error", e.toString());
    }
  }

  Future imgFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    _cropImage(File(pickedFile.path));
    setState(() {});
  }

  _imgFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _cropImage(File(pickedFile.path));

    setState(() {});
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedImage != null) {
      _image = croppedImage;
      setState(() {});
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              // Here we create one to set status bar color
              backgroundColor: Colors.grey[
                  200], // Set any color of status bar you want; or it defaults to your theme's primary color
            )),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 50.0),
                    child: Text('Additional',
                        style: TextStyle(
                            fontSize: 60.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 120.0, 0.0, 0.0),
                    child: Text('info',
                        style: TextStyle(
                            fontSize: 60.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(120.0, 120.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Colors.black,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(55),
                                child: Image.file(
                                  _image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          labelText: 'FIRST NAME',
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
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'LAST NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: [
                        Text(
                          "DATE OF BIRTH: ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                        ),
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(DateTime.parse(selectedDate.toString())),
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.grey;
                              return Colors
                                  .black; // Use the component's default.
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)))),
                      onPressed: () => _selectDate(context),
                      child: Text(
                        'SELECT DATE',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          'SPORT LEVEL:  ',
                          style: TextStyle(
                              fontSize: 16.r,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        sportLevelDropdown(),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                            labelText: 'HEIGHT ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)))),
                    SizedBox(height: 10.0),
                    TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                            labelText: 'WEIGHT ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)))),
                    SizedBox(height: 10.0),
                    TextField(
                        controller: aboutController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'ABOUT ME ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)))),
                    SizedBox(height: 10.0),
                    TextField(
                        controller: motivationController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'MY MOTIVATION ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)))),
                    SizedBox(height: 10.0),
                    TextField(
                        controller: countryController,
                        decoration: InputDecoration(
                            labelText: 'COUNTRY ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)))),
                    SizedBox(height: 10.0),
                    TextField(
                        controller: cityController,
                        decoration: InputDecoration(
                            labelText: 'CITY ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)))),
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
                              registrateUser();
                            },
                            child: Center(
                              child: Text(
                                'REGISTRATE',
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
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ]),
        ));
  }

  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       body: SingleChildScrollView(
  //         child: new Container(
  //             padding: EdgeInsets.only(top: 20),
  //             margin: EdgeInsets.all(16),
  //             child: Column(children: <Widget>[
  //               SizedBox(
  //                 height: 32,
  //               ),
  //               Container(
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     _showPicker(context);
  //                   },
  //                   child: CircleAvatar(
  //                     radius: 53,
  //                     backgroundColor: Colors.black,
  //                     child: _image != null
  //                         ? ClipRRect(
  //                             borderRadius: BorderRadius.circular(55),
  //                             child: Image.file(
  //                               _image,
  //                               width: 100,
  //                               height: 100,
  //                               fit: BoxFit.fitHeight,
  //                             ),
  //                           )
  //                         : Container(
  //                             decoration: BoxDecoration(
  //                                 color: Colors.grey[200],
  //                                 borderRadius: BorderRadius.circular(50)),
  //                             width: 100,
  //                             height: 100,
  //                             child: Icon(
  //                               Icons.camera_alt,
  //                               color: Colors.grey[800],
  //                             ),
  //                           ),
  //                   ),
  //                 ),
  //               ),
  //               firstNameField(),
  //               lastNameField(),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 children: [
  //                   Text("Your birthday: "),
  //                   Text(DateFormat('dd.MM.yyyy')
  //                       .format(DateTime.parse(selectedDate.toString()))),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20.0,
  //               ),
  //               RaisedButton(
  //                 color: Colors.black,
  //                 onPressed: () => _selectDate(context),
  //                 child: Text(
  //                   'Click to select your birthday',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //               sportLevelDropdown(),
  //               heightField(),
  //               weightField(),
  //               aboutField(),
  //               motivationField(),
  //               countryField(),
  //               cityField(),
  //               Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 16.0),
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       registrateUser();
  //                     },
  //                     child: Text("Registrate"),
  //                     style: ElevatedButton.styleFrom(
  //                         primary: Colors.black,
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: 50, vertical: 20),
  //                         textStyle: TextStyle(
  //                             fontSize: 30, fontWeight: FontWeight.bold)),
  //                   )),
  //             ])),
  //       ));
  // }

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

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String dropdownValue = 'Newbie';
  Widget sportLevelDropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 16,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat'),
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
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(labelText: 'Weight', hintText: 'Your weight'),
    );
  }

  Widget weightField() {
    return TextFormField(
      controller: weightController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
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
        dateOfBirth: DateFormat('dd.MM.yyyy').format(selectedDate) !=
                DateFormat('dd.MM.yyyy').format(DateTime.now())
            ? DateFormat('dd.MM.yyyy').format(selectedDate)
            : null,
        sportLevel: dropdownValue,
        height: double.tryParse(heightController.text) != null
            ? double.parse(heightController.text)
            : 0,
        weight: double.tryParse(weightController.text) != null
            ? double.parse(weightController.text)
            : 0,
        aboutMe: aboutController.text,
        motivation: motivationController.text,
        avatarUrl: avatarUrl,
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

  Future<void> registrateUser() async {
    var userJson = widget.userCredentials.toJson();

    userJson.removeWhere((key, value) => key == null || value == null);
    final userResponse =
        await http.post(Uri.https(ApiEndpoints.host, ApiEndpoints.userPOST),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(userJson));

    if (userResponse.statusCode == 200) {
      await sendImage();
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
        _showDialog("Success", "You has been successfully registered!");
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
