import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.black,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

File image;
String filename;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> getImageGallery() async {
    final pickImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickImage.path);
      filename = basename(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: image == null ? Text("Select an image") : uploadArea(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageGallery();
        },
        tooltip: 'Increment',
        child: Icon(Icons.image),
      ), // This trailing comma makes auto-formatting nicer for build
    );
  }
}

Widget uploadArea() {
  return Column(
    children: <Widget>[
      Image.file(image, width: double.infinity),
      RaisedButton(
        color: Colors.yellowAccent,
        child: Text('Upload'),
        onPressed: () {
          uploadImage();
        },
      )
    ],
  );
}

Future<String> uploadImage() async {
  StorageReference reference = FirebaseStorage.instance.ref().child(filename);
  StorageUploadTask uploadTask = reference.putFile(image);
  var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  var url = downUrl.toString();
  print("Download Url : $url");
  return "";
}
