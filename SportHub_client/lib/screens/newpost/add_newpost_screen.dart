import 'dart:convert';
import 'dart:io';
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
  void initState() {
    super.initState();

    getImagesPath();
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
              onPressed: () {},
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
