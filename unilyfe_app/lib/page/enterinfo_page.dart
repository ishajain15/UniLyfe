import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/loaders/color_loader_4.dart';
import 'package:unilyfe_app/customized_items/loaders/dot_type.dart';
import 'package:unilyfe_app/models/User.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

String year = 'freshman';

class EnterInfoPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => EnterInfoPage(),
      );

  @override
  _EnterInfoPageState createState() => _EnterInfoPageState();
}

class _EnterInfoPageState extends State<EnterInfoPage> {
  User user = User('', '', '', '', [], [], 0, 0);
  bool _validUsername = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _covidController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  TextEditingController _classesController = TextEditingController();
  TextEditingController _hobbiesController = TextEditingController();
  String _name = '';

  _getName() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(uid).get().then((result) {
      _name = result['name'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          children: <Widget>[
            pad,
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayTitle(context, snapshot);
                } else {
                  return buildLoading();
                }
              },
            ),
            /*Text(
              'Tell Us About Yourself',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),*/
            pad,
            _changeInfo('username...', _usernameController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('display name...', _displayNameController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('bio...', _bioController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            /*_changeInfo('profile pic...', _profilePictureController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('do you have covid-19?', _covidController),
            Container(
              padding: const EdgeInsets.all(4),
            ),
            _changeInfo('where did you last go?', _locationController),*/
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'I am a...  ',
                //style: TextStyle(color: Colors.grey, fontSize: 24),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
              _MyYearDropDownWidget(),
            ]),
            pad,
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _displayClassandHobbyBoxes(context, snapshot);
                } else {
                  return buildLoading();
                }
              },
            ),
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
                    print("user.username: " + user.username);
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    if (_usernameController.text != null &&
                        _usernameController.text != '') {
                      if ((user.username != _usernameController.text) &&
                          !await usernameCheck(_usernameController.text)) {
                        print('ALREADY TAKEN');
                        showAlertDialog(context);
                        //set valid username boolean to false
                        print("username is bad :(");
                        _validUsername = false;
                      } else {
                        _validUsername = true;
                        user.username = _usernameController.text;
                        await Provider.of(context)
                            .db
                            .collection('userData')
                            .doc(uid)
                            .update({'username': user.username});
                      }
                    }
                    if (_displayNameController.text != null &&
                        _displayNameController.text != '') {
                      user.displayName = _displayNameController.text;
                      print(_displayNameController.text);
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
                      /*setState(() {
                            _bioController.text = user.bio;
                          });*/
                      await Provider.of(context)
                          .db
                          .collection('userData')
                          .doc(uid)
                          .update({'bio': user.bio});
                    }

                    user.year = year;
                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'year': year});

                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'uid': uid});

                    var num = (math.Random().nextDouble() * 0xFFFFFF).toInt();
                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'color_code': num});

                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'profilepicture': "\"\""});

                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'awards_field': 0});

                    await Provider.of(context)
                        .db
                        .collection('userData')
                        .doc(uid)
                        .update({'points_field': 0});

                    if (_hobbiesController.text != null ||
                        _hobbiesController.text != '') {
                      user.hobbies = (_hobbiesController.text.split(', '));
                      print("hobbies: " + _hobbiesController.text);
                      setState(() {
                        user.hobbies = (_hobbiesController.text.split(', '));
                      });
                      await Provider.of(context)
                          .db
                          .collection('userData')
                          .doc(uid)
                          .update(
                              {'hobbies': _hobbiesController.text.split(', ')});
                    }

                    if (_classesController.text != null ||
                        _classesController.text != '') {
                      user.classes = (_classesController.text.split(', '));
                      print("classes: " + _classesController.text);
                      setState(() {
                        user.classes = (_classesController.text.split(', '));
                      });
                      await Provider.of(context)
                          .db
                          .collection('userData')
                          .doc(uid)
                          .update(
                              {'classes': _classesController.text.split(', ')});
                    }

                    if (_validUsername) {
                      print("username is valid?");
                      final auth = Provider.of(context).auth;
                      auth.setNewUser(false);
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                    //return HomePage();
                  },
                  child: Text('Submit'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }

  Widget displayTitle(context, snapshot) {
    return Column(children: <Widget>[
      FutureBuilder(
          future: _getName(),
          builder: (context, snapshot) {
            return Text(
              'Hi ' + _name + '! ' + 'Tell us about yourself',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            );
          })
    ]);
  }

  Widget pad = Container(
    padding: const EdgeInsets.all(32),
  );

  Widget _displayClassandHobbyBoxes(context, snapshot) {
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

  final db = FirebaseFirestore.instance;

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
}

class _MyYearDropDownWidget extends StatefulWidget {
  const _MyYearDropDownWidget({Key key}) : super(key: key);

  @override
  _MyYearDropDown createState() => _MyYearDropDown();
}

class _MyYearDropDown extends State<_MyYearDropDownWidget> {
  User user = User('', '', '', '', [], [], 0, 0);
  //String _currentYear = "";

  final db = FirebaseFirestore.instance;
  String dropdownValue = 'freshman';

  // ignore: always_declare_return_types

  @override
  Widget build(BuildContext context) {
    return _displayDropDown(context);
  }

  Widget _displayDropDown(context) {
    return DropdownButton<String>(
      value: dropdownValue,
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
          print('global variable year: ' + year);
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
          child: Text(
            value,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          ),
        );
      }).toList(),
    );
  }
}

Widget buildLoading() => Center(
        child: ColorLoader4(
      dotOneColor: Color(0xFFF46C6B),
      dotTwoColor: Color(0xFFF47C54),
      dotThreeColor: Color(0xFFFCAC54),
      dotType: DotType.square,
      duration: Duration(milliseconds: 1200),
    ));
