import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir_mu/services/crud.dart';
import 'package:random_string/random_string.dart';

class CreateMemoir extends StatefulWidget {

  final String user;

  const CreateMemoir({Key key, this.user}) : super(key: key);

  @override
  _CreateMemoirState createState() => _CreateMemoirState(user);
}

class _CreateMemoirState extends State<CreateMemoir> {

  final String user;

  String authorName, title, description;
  CrudMethods crudMethods = new CrudMethods();

  File selectedImage;
  bool _isLoading = false;

  _CreateMemoirState(this.user);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadMemoir() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("memoirImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();

      Map<String, String> memoirMap = {
        "imgURL": downloadUrl,
        "authorName": authorName,
        "title": title,
        "description": description
      };

      crudMethods.addData(memoirMap, user).then((result) {
        Navigator.pop(context);
      });

    } else {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
            "Memoir",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            "Mockup",
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[700]
            ),
          ),
        ]),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadMemoir();
            },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.file_upload)
            ),
          )
        ],
      ),
      body: _isLoading 
      ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) 
      : Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: selectedImage != null 
              ? Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect (
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    selectedImage, 
                    fit: BoxFit.cover,
                  )
                )
              ) 
              : Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 200, 
              decoration: BoxDecoration(
                color: Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(10)
              ),
              width: MediaQuery.of(context).size.width, 
              child: Icon(Icons.add_a_photo),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: "Who's Writing?"),
                    onChanged: (val){
                      authorName = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Memoir Title"),
                    onChanged: (val){
                      title = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "What happened?"),
                    onChanged: (val){
                      description = val;
                    },
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}