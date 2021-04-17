import 'dart:io';

import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserInfo userInfo;
  EditProfileScreen({Key key, @required this.userInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditProfileScreenState();
  }
}

class EditProfileScreenState extends State<EditProfileScreen> {
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

  String dropdownValue;
  bool isImageSelected = false;
  bool isImageUploaded = false;
  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userInfo.firstName;
    lastNameController.text = widget.userInfo.lastName;
    dateOfBirthController.text = widget.userInfo.dateOfBirth;
    heightController.text = widget.userInfo.height.toString();
    weightController.text = widget.userInfo.weight.toString();
    aboutController.text = widget.userInfo.aboutMe;
    dropdownValue = widget.userInfo.sportLevel;
    motivationController.text = widget.userInfo.motivation;
    countryController.text = widget.userInfo.country;
    cityController.text = widget.userInfo.city;
  }

  Future<void> updateProfile() async {
    try {
      String filename = _image.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_image.path, filename: filename),
      });
      var response =
          await Dio().post(ApiEndpoints.imageToBlobPOST, data: formData);
      if (response.statusCode == 200) {
        avatarUrl = response.data.toString();
        isImageUploaded = true;
        setUserInfo();
        var responseUpd =
            await Dio().put(ApiEndpoints.userInfoPUT, data: updatedUserInfo);
        if (responseUpd.statusCode == 200) {
          _showDialog("Success", "Profile was successful updated!");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomNavScreen()));
        } else {
          _showDialog("Error", "Something went wrong, please, try again.");
        }
      } else {
        _showDialog(
            "Error", "Problems with uploading image, please, try again.");
      }
    } catch (e) {
      print(e);
    }
  }

  final picker = ImagePicker();
  File _image;
  String avatarUrl;

  Future<void> sendImage() async {
    try {
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
      setState(() {
        isImageSelected = true;
      });
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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: new Container(
              padding: EdgeInsets.only(top: 20),
              margin: EdgeInsets.all(16),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: isImageSelected
                          ? CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.black,
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 100,
                                      height: 100,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ))
                          : CircleAvatar(
                              radius: 55.0,
                              backgroundImage:
                                  NetworkImage(widget.userInfo.avatarUrl),
                              backgroundColor: Colors.transparent,
                            )),
                ),
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
                        updateProfile();
                      },
                      child: Text("Update"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    )),
              ])),
        ));
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
      items: <String>['Newer', 'Middle', 'Advanced']
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

  UserInfo updatedUserInfo;
  void setUserInfo() {
    updatedUserInfo = new UserInfo(
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
        avatarUrl: isImageUploaded ? avatarUrl : widget.userInfo.avatarUrl,
        userId: SharedPrefs.userId);
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
