import 'dart:io';

import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/pages/user_profile_page.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
  String date;
  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userInfo.firstName;
    lastNameController.text = widget.userInfo.lastName;
    dateOfBirthController.text = widget.userInfo.dateOfBirth;
    date = widget.userInfo.dateOfBirth;
    heightController.text = widget.userInfo.height.toString();
    weightController.text = widget.userInfo.weight.toString();
    aboutController.text = widget.userInfo.aboutMe;
    dropdownValue = widget.userInfo.sportLevel;
    motivationController.text = widget.userInfo.motivation;
    countryController.text = widget.userInfo.country;
    cityController.text = widget.userInfo.city;
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Future<void> updateProfile() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      if (_image != null) {
        var response = await sendImage();
        if (response.statusCode == 200) {
          avatarUrl = response.data.toString();
          isImageUploaded = true;
        } else {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          _showDialog(
              "Error", "Problems with uploading image, please, try again.");
        }
      }

      setUserInfo();
      Dio dio = new Dio();
      dio.options.headers['authorization'] = 'Bearer ' + SharedPrefs.token;
      var responseUpd =
          await dio.put(ApiEndpoints.userInfoPUT, data: updatedUserInfo);
      if (responseUpd.statusCode == 200) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavScreen()),
            (Route<dynamic> route) => false);
        _showDialog("Готово", "Профиль успешно обновлён!");
      } else {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        _showDialog("Error", "Something went wrong, please, try again.");
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      print(e);
    }
  }

  final picker = ImagePicker();
  File _image;
  String avatarUrl;

  Future<Response<dynamic>> sendImage() async {
    try {
      String filename = _image.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_image.path, filename: filename),
      });
      Dio dio = new Dio();
      dio.options.headers['authorization'] = 'Bearer ' + SharedPrefs.token;
      var response =
          await dio.post(ApiEndpoints.imageToBlobPOST, data: formData);
      return response;
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
                      title: new Text('Галерея'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Камера'),
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
        appBar: AppBar(
            backgroundColor: Colors.grey[900],
            title: Text(
              "Ред. профиль",
              style: GoogleFonts.workSans(
                  fontStyle: FontStyle.normal,
                  fontSize: 25.r,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              SizedBox(height: 20.r),
              Container(
                  padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: Column(children: <Widget>[
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                              : (Uri.parse(widget.userInfo.avatarUrl).isAbsolute
                                  ? CircleAvatar(
                                      radius: 55.0,
                                      backgroundImage: NetworkImage(
                                          widget.userInfo.avatarUrl),
                                      backgroundColor: Colors.transparent,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/icon.jpg"),
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.black,
                                      radius: 45.r,
                                    ))),
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          labelText: 'ИМЯ',
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
                        labelText: 'ФАМИЛИЯ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    dateOfBirthField(),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          'СПОРТИВНЫЙ УРОВЕНЬ:  ',
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
                            labelText: 'РОСТ ',
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
                            labelText: 'ВЕС ',
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
                            labelText: 'О СЕБЕ ',
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
                            labelText: 'МОТИВАЦИЯ ',
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
                            labelText: 'СТРАНА ',
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
                            labelText: 'ГОРОД ',
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
                              updateProfile();
                            },
                            child: Center(
                              child: Text(
                                'ОБНОВИТЬ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  ]))
            ])));
  }

  Widget dateOfBirthField() {
    return TextFormField(
        controller: dateOfBirthController,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            labelText: 'ДАТА РОЖДЕНИЯ',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))));
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
      items: <String>['Новичок', 'Средний', 'Продвинутый']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
