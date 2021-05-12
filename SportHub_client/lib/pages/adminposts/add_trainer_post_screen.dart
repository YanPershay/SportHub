import 'dart:io';

import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/admin_post.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/dialogs.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewTrainerPostScreen extends StatefulWidget {
  @override
  _NewTrainerPostScreenState createState() => _NewTrainerPostScreenState();
}

class _NewTrainerPostScreenState extends State<NewTrainerPostScreen> {
  TextEditingController postTextController = new TextEditingController();
  TextEditingController titleTextController = new TextEditingController();
  File _image;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<void> sendPost() async {
    try {
      if (_image == null) {
        Dialogs.showMyDialog(context, "Error", "Please, select image.");
      } else {
        Dialogs.showLoadingDialog(context, _keyLoader);
        if (titleTextController.text == "" || postTextController.text == "") {
          Dialogs.showMyDialog(context, "Error", "Please, fill all fields.");
        } else {
          String filename = _image.path.split('/').last;

          FormData formData = FormData.fromMap({
            "file":
                await MultipartFile.fromFile(_image.path, filename: filename),
          });
          Dio dio = new Dio();
          dio.options.headers['authorization'] = 'Bearer ' + SharedPrefs.token;
          var response =
              await dio.post(ApiEndpoints.imageToBlobPOST, data: formData);

          if (response.statusCode == 200) {
            AdminPost post = new AdminPost(
                title: titleTextController.text,
                text: postTextController.text,
                imageUrl: response.data.toString(),
                dateCreated: DateTime.now().toString(),
                categoryId: 3,
                duration: int.parse(durationDropdownValue),
                complexity: int.parse(complexityDropdownValue),
                isUpdated: false,
                userId: SharedPrefs.userId);

            var responsePost =
                await dio.post(ApiEndpoints.trainerPostPOST, data: post);
            if (responsePost.statusCode == 200) {
              return Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => BottomNavScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                  .pop();
              _showDialog(
                  "Error", "Problems with adding Post. Try again later.");
            }
          } else {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
            _showDialog(
                "Error", "Problems with uploading image, please, try again.");
          }
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        }
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      _showDialog("Error", e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final picker = ImagePicker();

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

  String durationDropdownValue = '1';
  String complexityDropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "New trainer post",
              style: GoogleFonts.workSans(
                fontStyle: FontStyle.normal,
                fontSize: 25.r,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  iconSize: 30.r,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                    child: TextFormField(
                      controller: titleTextController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Title',
                      ),
                      style: GoogleFonts.workSans(
                        fontStyle: FontStyle.normal,
                        fontSize: 25.r,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Duration: ",
                              style: GoogleFonts.workSans(
                                fontStyle: FontStyle.normal,
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            DropdownButton<String>(
                              value: durationDropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20.r,
                              elevation: 1,
                              style: TextStyle(color: Colors.black),
                              underline:
                                  Container(height: 2, color: Colors.white),
                              onChanged: (String newValue) {
                                setState(() {
                                  durationDropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20.r),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          children: [
                            Text(
                              "Complexity: ",
                              style: GoogleFonts.workSans(
                                fontStyle: FontStyle.normal,
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            DropdownButton<String>(
                              value: complexityDropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20.r,
                              elevation: 1,
                              style: TextStyle(color: Colors.black),
                              underline:
                                  Container(height: 2, color: Colors.white),
                              onChanged: (String newValue) {
                                setState(() {
                                  complexityDropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20.r),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        color: Colors.black,
                        child: _image != null
                            ? ClipRRect(
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  //borderRadius: BorderRadius.circular(50)
                                ),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: postTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    color: Colors.grey[900],
                    child: Text("Send"),
                    onPressed: () {
                      sendPost();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
