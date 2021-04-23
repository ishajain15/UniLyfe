import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unilyfe_app/customized_items/buttons/photo_posting_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/models/photo_post.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

int selection = 0;

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
  File _image;
  Future getImagefromcamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImagefromGallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    String _location;
    String _title;
    // ignore: unused_local_variable
    String text;
    return Scaffold(
      appBar: AppBar(
        title: Text('Take photo or Upload from Gallery'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Center(
          /* child: Text(
              'Image Picker Example in Flutter',
              style: TextStyle(fontSize: 20),
            ), */
          // start textfield

          TextField(
            decoration: InputDecoration(
              hintText: 'Add a caption',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              text = value.trim();
              _title = value.trim();
            },
          ),
          // end textfield
          TextField(
            decoration: InputDecoration(
              hintText: 'Add a location',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 4.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              text = value.trim();
              _location = value.trim();
            },
          ),
          //),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text('No Image is picked')
                    : Image.file(_image),
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
              ),
              MyAppOne(),
              ElevatedButton(
                onPressed: () async {

                  var channel = 'Post';
                  if (selection == 0) {
                    channel = 'FOOD';
                  } else if (selection == 1) {
                    channel = 'STUDY';
                  } else {
                    print(selection);
                    channel = 'SOCIAL';
                  }

                  final uid = await Provider.of(context).auth.getCurrentUID();
                  var doc = db.collection('posts').doc();
                  final post = PhotoPost(
                      doc.id,
                      _title,
                      DateTime.now(),
                      null,
                      channel,
                      uid,
                      0,
                      false,
                      {uid: false},
                      null,
                      _location,
                      null,
                      null, null);

                  

                  await db.collection('userData').doc(uid).get().then((result) {
                    post.username = result['username'];
                  });

                  await db
                    .collection('userData')
                    .doc(uid)
                    .update({'points_field': FieldValue.increment(10)});
                  post.postid = doc.id;

                  //DocumentReference channel;
                  if (selection == 0) {
                    //await db.collection("food_posts").add(post.toJson());
                    await db
                        .collection('food_posts')
                        .doc(doc.id)
                        .set(post.toJson());
                  } else if (selection == 1) {
                    //await db.collection("study_posts").add(post.toJson());
                    await db
                        .collection('study_posts')
                        .doc(doc.id)
                        .set(post.toJson());
                  } else {
                    //await db.collection("social_posts").add(post.toJson());
                    await db
                        .collection('social_posts')
                        .doc(doc.id)
                        .set(post.toJson());
                  }
                  await db.collection('posts').doc(doc.id).set(post.toJson());
                  await db
                      .collection('userData')
                      .doc(uid)
                      .collection('event_posts')
                      .doc(doc.id)
                      .set(post.toJson());
                  //  Navigator.of(context).popUntil((route) => route.isFirst);
                  //  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pop(context);
                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => CreatePage())).then((_) => refresh());
                },
                //   child: Text("Post"),
                //  onPressed: () async{
                child: Text('SUBMIT'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyAppOne extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppOne> {
  List<bool> isSelected;

  @override
  void initState() {
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [true, false, false];
    selection = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        // logic for button selection below
        onPressed: (int index) {
          setState(() {
            for (var i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
              if (isSelected[i] == true) {
                selection = i;
                print('INDEX: $i');
              }
            }
          });
        },
        isSelected: isSelected,
        children: <Widget>[
          // first toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'FOOD',
            ),
          ),
          // second toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'STUDY',
            ),
          ),
          // third toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SOCIAL',
            ),
          ),
        ],
      ),
    );
  }
}
