import 'dart:convert';
import 'dart:io';
import 'package:SportHub_client/bottom_nav_screen.dart';
import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/file.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  List<FileModel> files = [];
  FileModel selectedModel;
  String image;
  void getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;
    files =
        images.map<FileModel>((e) => FileModel.fromJson(e)).take(10).toList();
    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
  }

  TextEditingController controller = new TextEditingController();

  Future<void> sendImage() async {
    try {
      String filename = image.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image, filename: filename),
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
          return Navigator.push(context,
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
      _showDialog("Error", e);
    }
  }

  @override
  void initState() {
    super.initState();

    getImagesPath();
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
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: CircleAvatar(
          backgroundImage: AssetImage("assets/profile.jpg"),
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
            new TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            Row(
              children: <Widget>[
                DropdownButtonHideUnderline(
                    child: DropdownButton<FileModel>(
                  items: getItems(),
                  onChanged: (FileModel d) {
                    assert(d.files.length > 0);
                    image = d.files[0];
                    setState(() {
                      selectedModel = d;
                    });
                  },
                  value: selectedModel,
                ))
              ],
            ),
            Divider(),
            Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: image != null
                    ? Image.file(File(image),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.45)
                    : Container()),
            Divider(),
            selectedModel == null && selectedModel.files.length < 1
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (_, i) {
                        var file = selectedModel.files[i];
                        return GestureDetector(
                          child: Image.file(
                            File(file),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            setState(() {
                              image = file;
                            });
                          },
                        );
                      },
                      itemCount: selectedModel.files.length,
                    ),
                  ),
            ElevatedButton(
              child: Text('Bottom'),
              onPressed: () {
                sendImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    return files
            .map((e) => DropdownMenuItem(
                  child: Text(e.folder),
                  value: e,
                ))
            .toList() ??
        [];
  }
}
