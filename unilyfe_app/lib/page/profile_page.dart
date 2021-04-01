import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:unilyfe_app/customized_items/buttons/lets_go_button.dart';
import 'package:unilyfe_app/customized_items/buttons/logout_button.dart';
import 'package:unilyfe_app/models/User.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:network/network.dart';

String year = '';

class ProfilePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _validUsername = true;
  User user = User('', '', '', '', [], []);
  String _currentUsername = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _covidController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  TextEditingController _classesController = TextEditingController(text: '');
  TextEditingController _hobbiesController = TextEditingController(text: '');
  bool circular = false;
  PickedFile _imageFile;
  //final _globalkey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
            child: Row(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(310, 0, 0, 0),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: () {
                _EditProfile(context);
              },
              child: Text('Edit Profile'),
            ),
          ),
        ])),
        _imageProfile(context),
        FutureBuilder(
          future: Provider.of(context).auth.getCurrentUID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return displayUserInformation(context, snapshot);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        FutureBuilder(
          future: Provider.of(context).auth.getCurrentUID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _displayClasses(context, snapshot);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

        /* // ignore: deprecated_member_use
        FlatButton(
            onPressed: () => debugPrint('points lol pressed'),
            child: Text('Points: 0',
                style: TextStyle(fontSize: 16, color: Color(0xFFF46C6B)))
        ), */
        Text(
                'Points: 0',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ],
    ));
  }

  Widget _imageProfile(context) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 100.0,
          backgroundImage: _imageFile == null
              ? AssetImage('assets/empty-profile.png')
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(context)),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: const Color(0xFFF99E3E),
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Raleway'),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera",
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  )),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery",
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    var pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      print('_imageFile: $_imageFile');
    });
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .doc(uid)
        .set({'profilepicture': pickedFile});
  }

  Widget displayUserInformation(context, snapshot) {
    // ignore: unused_local_variable
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {}
              return Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          user.displayName,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          user.year,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          user.bio,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                    ],
                  ));
            }),
      ],
    );
  }

  Widget _displayClasses(context, snapshot) {
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {}
              return Container(
                  child: Column(
                children: [
                  chipList(user.hobbies, const Color(0xFFF56D6B)),
                  chipList(user.classes, const Color(0xFFF99E3E))
                ],
              ));
            }),
      ],
    );
  }

  Widget pad = Container(
    padding: const EdgeInsets.all(32),
  );

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  Widget chipList(List<String> things, Color color) {
    var list = <Widget>[];
    for (var i = 0; i < things.length; i++) {
      list.add(_buildChip(things[i], color));
    }
    Widget chips = Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: list));
    return chips;
  }

  Widget _changeInfo(
      String textBoxText, TextEditingController editingController) {
    return TextField(
      controller: editingController,
      autofocus: false,
      style: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFfae9d7),
        hintText: textBoxText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }

  //final db = FirebaseFirestore.instance;

  // ignore: always_declare_return_types
  showAlertDialog(BuildContext context) async {
    // set up the button
    var email = await Provider.of(context).auth.getEmail();
    var suggested = await generateUsername(email);
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('OK'),
    );

    // set up the AlertDialog
    var alert = AlertDialog(
      title: Text('PLEASE CHOOSE ANOTHER USERNAME'),
      content: Text('Suggested usernames: $suggested'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final firestore = FirebaseFirestore.instance; //
  fire_auth.FirebaseAuth auth = fire_auth.FirebaseAuth
      .instance; //recommend declaring a reference outside the methods

  // ignore: always_declare_return_types
  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(uid).get().then((result) {
      user.username = result['username'].toString();
      user.displayName = result['displayName'].toString();
      user.bio = result['bio'].toString();
      user.year = result['year'].toString();
      _currentUsername = result['username'].toString();
      user.classes = List.from(result['classes']);
      user.hobbies = List.from(result['hobbies']);
      _classesController = TextEditingController(
          text: user.classes
              .toString()
              .substring(1, ((user.classes.toString()).length - 1)));
      _hobbiesController = TextEditingController(
          text: user.hobbies
              .toString()
              .substring(1, ((user.hobbies.toString()).length - 1)));
    });
  }

  Future<bool> usernameCheck(String username) async {
    final result = await firestore
        .collection('userData')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  Future<String> generateUsername(String email) async {
    var username = email.substring(0, email.indexOf('@'));
    var num = 1;
    if (!await usernameCheck(username)) {
      print(username + ' exists');
      while (!await usernameCheck(username + num.toString())) {
        num += 1;
      }
    }
    print(username);
    return username +
        num.toString() +
        ' ' +
        username +
        (num + 1).toString() +
        ' ' +
        username +
        (num + 2).toString();
  }

  void _EditProfile(context) {
    // ignore: unused_local_variable
    final _dropDown = _MyYearDropDownWidget();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                pad,
                _changeInfo('change username...', _usernameController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo('change display name...', _displayNameController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo('change bio...', _bioController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                /*_changeInfo('change profile pic...', _profilePictureController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo('do you have covid-19?', _covidController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo('where did you last go?', _locationController),*/
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'I am a...  ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _dropDown,
                    ]),
                FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _displayClassandHobbyBoxes(context, snapshot);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                pad,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFF56D6B),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () async {
                        _getProfileData();
                        final uid =
                            await Provider.of(context).auth.getCurrentUID();
                        if (_usernameController.text != null &&
                            _usernameController.text != '') {
                          print(_currentUsername);
                          print(_usernameController.text);
                          if ((_currentUsername != _usernameController.text) &&
                              !await usernameCheck(_usernameController.text)) {
                            print('ALREADY TAKEN');
                            showAlertDialog(context);
                            _validUsername = false;
                          } else {
                            _validUsername = true;
                            user.username = _usernameController.text;
                            setState(() {
                              _usernameController.text = user.username;
                            });
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .update({'username': user.username});
                          }
                        }
                        if (_usernameController.text == '' ||
                            _usernameController.text == null) {
                          _validUsername = true;
                        }
                        if (_displayNameController.text != null &&
                            _displayNameController.text != '') {
                          user.displayName = _displayNameController.text;
                          print(_displayNameController.text);
                          setState(() {
                            _displayNameController.text = user.displayName;
                          });
                          await Provider.of(context)
                              .db
                              .collection('userData')
                              .doc(uid)
                              .update({'displayName': user.displayName});
                        }
                        if (_bioController.text != null &&
                            _bioController.text != '') {
                          user.bio = _bioController.text;
                          print(_bioController.text);
                          setState(() {
                            _bioController.text = user.bio;
                          });
                          await Provider.of(context)
                              .db
                              .collection('userData')
                              .doc(uid)
                              .update({'bio': user.bio});
                        }
                        if (year != '') {
                          user.year = year;
                          setState(() {
                            year = user.year;
                          });
                          await Provider.of(context)
                              .db
                              .collection('userData')
                              .doc(uid)
                              .update({'year': year});
                        }

                        if (_hobbiesController.text != null || _hobbiesController.text != '') {
                          user.hobbies = (_hobbiesController.text.split(', '));
                          print("hobbies: " + _hobbiesController.text);
                          setState(() {
                            user.hobbies =
                                (_hobbiesController.text.split(', '));
                          });
                          await Provider.of(context)
                              .db
                              .collection('userData')
                              .doc(uid)
                              .update({
                            'hobbies': _hobbiesController.text.split(', ')
                          });
                        }
                        if (_classesController.text != null || _classesController.text != '') {
                          user.classes = (_classesController.text.split(', '));
                          print("classes: " + _classesController.text);
                          setState(() {
                            user.classes =
                                (_classesController.text.split(', '));
                          });
                          await Provider.of(context)
                              .db
                              .collection('userData')
                              .doc(uid)
                              .update({
                            'classes': _classesController.text.split(', ')
                          });
                        }

                        /*if (_profilePictureController.text != null &&
                              _profilePictureController.text != "") {
                            user.picturePath = _profilePictureController.text;
                            print(_profilePictureController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }*/
                        /*if (_covidController.text != null) {
                            user.covid = _covidController.text;
                            print(_covidController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }*/
                        /*if (_locationController.text != null) {
                            user.location = _locationController.text;
                            print(_locationController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }*/
                        if (_validUsername) {
                          print("username is valid?");
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _displayClassandHobbyBoxes(context, snapshot) {
    return Column(children: <Widget>[
      FutureBuilder(
          future: _getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {}
            return Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 60)),
                  child: TextField(
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold),
                      autofocus: false,
                      controller: _classesController,
                      decoration: InputDecoration(
                        hintText: 'Your classes',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(300, 60)),
                  child: TextField(
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold),
                      autofocus: false,
                      controller: _hobbiesController,
                      decoration: InputDecoration(
                        hintText: 'Your hobbies',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
            ]);
          })
    ]);
  }
}

class _MyYearDropDownWidget extends StatefulWidget {
  const _MyYearDropDownWidget({Key key}) : super(key: key);

  @override
  _MyYearDropDown createState() => _MyYearDropDown();
}

class _MyYearDropDown extends State<_MyYearDropDownWidget> {
  User user = User('', '', '', '', [], []);
  //String _currentYear = "";

  final db = FirebaseFirestore.instance;
  String dropdownValue = 'Freshman';

  // ignore: always_declare_return_types
  _getYearData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(uid).get().then((result) {
      if (year == '') {
        user.year = result['year'].toString();
        // _currentYear = result["year"].toString();
      } else {
        user.year = year;
        //_currentYear = year;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _displayDropDown(context, snapshot);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _displayDropDown(context, snapshot) {
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _getYearData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {}
              return Container(
                  child: DropdownButton<String>(
                value: user.year,
                //icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.grey, fontSize: 24),
                underline: Container(
                  height: 2.5,
                  color: const Color(0xFFF99E3E),
                ),
                onChanged: (String newValue) async {
                  user.year = newValue;
                  setState(() {
                    year = newValue;
                    //print('global variable year: ' + year);
                    dropdownValue = newValue;
                  });
                  /*final uid = await Provider.of(context).auth.getCurrentUID();
                  await Provider.of(context)
                      .db
                      .collection('userData')
                      .doc(uid)
                      .update({"year": dropdownValue});*/
                },
                items: <String>['freshman', 'sophomore', 'junior', 'senior']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        )),
                  );
                }).toList(),
              ));
            }),
      ],
    );
  }
}
