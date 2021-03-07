import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:SportHub_client/utils/file.dart';
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
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
  }

  @override
  void initState() async {
    super.initState();
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    getImagesPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: <Widget>[
          new TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          Row(
            children: <Widget>[
              DropdownButtonHideUnderline(
                  child: DropdownButton(items: getItems(), onChanged: (d) {}))
            ],
          ),
          Divider(),
          Container(
              height: MediaQuery.of(context).size.height * 0.45,
              child: image != null
                  ? Image.file(File(image),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.45)
                  : Container()),
          Divider(),
        ],
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
