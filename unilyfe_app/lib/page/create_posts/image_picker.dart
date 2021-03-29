import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unilyfe_app/customized_items/buttons/photo_posting_button.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  PickedFile _image;
  Future getImagefromcamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
  Future getImagefromGallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String text;
    return Scaffold(
      appBar: AppBar(
        title: Text('Take photo or Upload from Gallery'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            /* child: Text(
              'Image Picker Example in Flutter',
              style: TextStyle(fontSize: 20),
            ), */
            // start textfield
            
            child: TextField(
            decoration: InputDecoration(
              
                hintText: 'Add a caption',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
                ),
            ),
            onChanged: (value) {text = value.trim();},
            ),
            // end textfield 
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text('No Image is picked')
                    : FileImage(File(_image.path)),
                    //FileImage(File(_imageFile.path))
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: getImagefromcamera,
                tooltip: 'pickImage',
                child: Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: getImagefromGallery,
                tooltip: 'Pick Image',
                child: Icon(Icons.camera_alt),
              )
            ],
          ),
          // start Post button
          // ignore: deprecated_member_use
          /* FlatButton(
            onPressed: () => debugPrint('Photo post button pressed'),
            child: Text('Post',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFF46C6B)
              )
            )
          ), */
          // end Post button
        PhotoPostingButton(),
        ],
      ),
    );
  }
}