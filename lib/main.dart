import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:file_handling/camera.dart';

import 'user.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    ),
  );
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/programNew.txt');
  }

  // Future<String> getImagePath() async {
  //   final path = await _localPath;
  //
  //   return path;
  // }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents.toString();
    } catch (e) {
      // If encountering an error, return 0
      return "noAvai";
    }
  }

  Future<File> writeCounter(String input) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(input);
  }
}

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  String _output = "noAvai";

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _output = value;
      });
    });
  }

  Future<File> _incrementCounter(List<String> newInput, List<bool> todayWork) {
    if (_output == "noAvai") {
      List<dynamic> completedDays = [newInput];
      ProgramFile s1 = new ProgramFile(todayWork, completedDays);
      String encodeStudent = jsonEncode(s1);
      return widget.storage.writeCounter(encodeStudent);
    }
    Map<String, dynamic> preInput = jsonDecode(_output);

    List<dynamic> completedDays = preInput['completedDays'];

    completedDays.add(newInput);

    ProgramFile s1 = new ProgramFile(todayWork, completedDays);
    String encodeStudent = jsonEncode(s1);
    // Write the variable as a string to the file.
    return widget.storage.writeCounter(encodeStudent);
  }

  // Future<File?> _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //     print(imageFile);
  //     return File(pickedFile.path);
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    // List<List<String>> completedDays = [
    //   ["1", "pic1.jpg", "It was a amazing day"],
    //   ["2", "pic2.jpg", "It was Hard a little"],
    //   ["3", "pic3.jpg", "I felt to quit but I didn't"]
    // ];
    //
    // List<bool> todayWork = [
    //   false,
    //   false,
    //   false,
    //   false,
    //   false
    // ];

    List<String> newInput = ["7", "pic4.jpg", "It was nice but Hard"];

    List<bool> todayWork = [false, true, false, false, false];

    // FileImage _image = FileImage(File('/data/user/0/com.example.file_handling/cache/scaled_IMG_20230219_181539.jpg'));
    // Image _image = '/data/user/0/com.example.file_handling/cache/scaled_IMG_20230219_181539.jpg';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Ready to write: ${newInput} and ${todayWork}"),
              Text(
                _output,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _incrementCounter(newInput, todayWork);
                  print(_output);
                },
                child: Text("Done"),
              ),
              Container(child: MyPage(), width: MediaQuery.of(context).size.width, height: 1000,)
            ],
          ),
        ),
      ),
    );
  }
}

