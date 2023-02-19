import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Variables
  File? imageFile = null;

  // File imageFile = File('/data/user/0/com.example.file_handling/cache/scaled_IMG_20230219_181539.jpg');

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
          // child: imageFile == null
          //     ? Container(
          //   alignment: Alignment.center,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       ElevatedButton(
          //         onPressed: () {
          //           _getFromGallery();
          //         },
          //         child: Text("PICK FROM GALLERY"),
          //       ),
          //       Container(
          //         height: 40.0,
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           _getFromCamera();
          //         },
          //         child: Text("PICK FROM CAMERA"),
          //       )
          //     ],
          //   ),
          // ): Container(
          //   height: 300,
          //   child: ClipRect(
          //     child: Image.file(
          //       imageFile!,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // )
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _getFromGallery();
                },
                child: Text("Pick from Gallery"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    _getFromCamera();
                  },
                  child: Text("Pick from Camera"),
                ),
              ),
              Container(
                child: imageFile == null
                    ? Container()
                    : Container(
                        height: 300,
                        child: ClipRect(
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
