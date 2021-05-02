import 'dart:io';
import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  //List<FileModel> files = [];
  //FileModel selectedModel;
  //String image;
  // void getImagesPath() async {
  //   var imagePath = await StoragePath.imagesPath;
  //   var images = jsonDecode(imagePath) as List;
  //   files =
  //       images.map<FileModel>((e) => FileModel.fromJson(e)).take(10).toList();
  //   if (files != null && files.length > 0)
  //     setState(() {
  //       selectedModel = files[0];
  //       image = files[0].files[0];
  //     });
  // }
  //

  TextEditingController controller = new TextEditingController();
  File _image;

  Future<void> sendImage() async {
    try {
      String filename = _image.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_image.path, filename: filename),
      });
      var response =
          await Dio().post(ApiEndpoints.imageToBlobPOST, data: formData);
      if (response.statusCode == 200) {
        Post post = new Post(
            text: controller.text,
            imageUrl: response.data.toString(),
            dateCreated: DateTime.now().toString(),
            isUpdated: false,
            userId: SharedPrefs.userId);
        var responsePost =
            await Dio().post(ApiEndpoints.addPostPOST, data: post);
        if (responsePost.statusCode == 200) {
          return Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavScreen()));
        } else {
          _showDialog("Error", "Problems with adding Post. Try again later.");
        }
      } else {
        _showDialog(
            "Error", "Problems with uploading image, please, try again.");
      }
      //return response.data.toString();
    } catch (e) {
      _showDialog("Error", e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    //getImagesPath();
  }

  final picker = ImagePicker();

  Future imgFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    _cropImage(File(pickedFile.path));
    setState(() {
      // if (pickedFile != null) {
      //   _image = File(pickedFile.path);
      // } else {
      //   print('No image selected.');
      // }
    });
  }

  _imgFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _cropImage(File(pickedFile.path));

    setState(() {
      //if (pickedFile != null) {
      //  _image = File(pickedFile.path);
      //} else {
      //  print('No image selected.');
      //}
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "New post",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              iconSize: 40,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  width: 155,
                  height: 140,
                  color: Colors.black,
                  child: _image != null
                      ? ClipRRect(
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
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 20.r),
              ),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              color: Colors.grey[900],
              child: Text("Send"),
              onPressed: () {
                sendImage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
