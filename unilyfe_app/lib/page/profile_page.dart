import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/back_button.dart';
import 'package:unilyfe_app/customized_items/buttons/lets_go_button.dart';
import 'package:unilyfe_app/customized_items/buttons/logout_button.dart';
import 'package:unilyfe_app/models/User.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User("", "", "", "");
  String _currentUsername = "";
  String _currentYear = "";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _profilePictureController = TextEditingController();
  TextEditingController _covidController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  //final db = FirebaseFirestore.instance;

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
        _profilePicture(),
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
        chipList([
          'Photography',
          'Tiktok Star',
          'Photoshop',
          'Coder',
          'Baker',
          'Chef',
          'Data Scientist',
          'Painter',
          'Spotify Playlist Curator',
          'Insomniac'
        ], const Color(0xFFF56D6B)),
        chipList([
          'CS 242',
          'CS 252',
          'CS 307',
          'MA 351',
          'COM 217',
          'AD 255',
          'WGSS 280',
        ], const Color(0xFFF99E3E)),
        LetsGoButton(),
        //BackButtonWidget(),
        LogoutButtonWidget(),
      ],
    ));
  }

  Widget displayUserInformation(context, snapshot) {
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
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: list));
    return chips;
  }

  Widget _changeInfo(
      String textBoxText, TextEditingController editingController) {
    return TextField(
      controller: editingController,
      autofocus: false,
      style: TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFfae9d7),
        hintText: textBoxText,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
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

  showAlertDialog(BuildContext context) async {
    // set up the button
    String email = await Provider.of(context).auth.getEmail();
    String suggested = await generateUsername(email);
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("PLEASE CHOOSE ANOTHER USERNAME"),
      content: Text("Suggested usernames: ${suggested}"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final firestore = FirebaseFirestore.instance; //
  fire_auth.FirebaseAuth auth = fire_auth.FirebaseAuth
      .instance; //recommend declaring a reference outside the methods

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(uid).get().then((result) {
      user.username = result["username"].toString();
      user.displayName = result["displayName"].toString();
      user.bio = result["bio"].toString();
      user.year = result["year"].toString();
      _currentUsername = result["username"].toString();
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
    String username = email.substring(0, email.indexOf('@'));
    int num = 1;
    if (!await usernameCheck(username)) {
      print(username + " exists");
      while (!await usernameCheck(username + num.toString())) {
        num += 1;
      }
    }
    print(username);
    return username +
        num.toString() +
        " " +
        username +
        (num + 1).toString() +
        " " +
        username +
        (num + 2).toString();
  }

  void _EditProfile(context) {
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
                _changeInfo("change username...", _usernameController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo("change display name...", _displayNameController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo("change bio...", _bioController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo("change profile pic...", _profilePictureController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo("do you have covid-19?", _covidController),
                Container(
                  padding: const EdgeInsets.all(4),
                ),
                _changeInfo("where did you last go?", _locationController),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "I am a...  ",
                        style: TextStyle(color: Colors.grey, fontSize: 24),
                      ),
                      _dropDown,
                    ]),
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
                        child: Text('Submit'),
                        onPressed: () async {
                          _getProfileData();
                          final uid =
                              await Provider.of(context).auth.getCurrentUID();
                          if (_usernameController.text != null &&
                              _usernameController.text != "") {
                            print(_currentUsername);
                            print(_usernameController.text);
                            if ((_currentUsername !=
                                    _usernameController.text) &&
                                !await usernameCheck(
                                    _usernameController.text)) {
                              print("ALREADY TAKEN");
                              showAlertDialog(context);
                            } else {
                              user.username = _usernameController.text;
                              setState(() {
                                _usernameController.text = user.username;
                              });
                              await Provider.of(context)
                                  .db
                                  .collection('userData')
                                  .doc(uid)
                                  .update({"username": user.username});
                            }
                          }
                          if (_displayNameController.text != null &&
                              _displayNameController.text != "") {
                            user.displayName = _displayNameController.text;
                            print(_displayNameController.text);
                            setState(() {
                              _displayNameController.text = user.displayName;
                            });
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .update({"displayName": user.displayName});
                          }
                          if (_bioController.text != null &&
                              _bioController.text != "") {
                            user.bio = _bioController.text;
                            print(_bioController.text);
                            setState(() {
                              _bioController.text = user.bio;
                            });
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .update({"bio": user.bio});
                          }
                          print("_dropDown._callGetCurrentYear(context): " +
                              _dropDown._callGetCurrentYear());

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
                          _getProfileData();
                          print("user.year: " + user.year);

                          Navigator.of(context).pop();
                        })
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
      },
    );
  }
}

class _profilePicture extends StatefulWidget {
  @override
  _myProfilePictureState createState() => _myProfilePictureState();
}

class _myProfilePictureState extends State<_profilePicture> {
  //String picture = 'assets/gayathri.png';
  /*void _changePicture(String path) {
    setState(() {
      if (picture == 'assets/gayathri_armstrong.png') {
        picture = path;
        print("new picture: " + picture);
        return;
      }
      if (picture == 'assets/gayathri.png') {
        picture = path;
        print("new picture: " + picture);
        return;
      }
    });
  }*/

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('hello');
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/gayathri_armstrong.png'),
            ),
          ),
        ));
  }
}

class _MyYearDropDownWidget extends StatefulWidget {
  const _MyYearDropDownWidget({Key key}) : super(key: key);

  _callGetCurrentYear() => createState()._getCurrentYear();

  @override
  _MyYearDropDown createState() => _MyYearDropDown();
}

class _MyYearDropDown extends State<_MyYearDropDownWidget> {
  User user = User("", "", "", "");
  String _currentYear = "";

  String _getCurrentYear() {
    return _currentYear;
  }

  final db = FirebaseFirestore.instance;
  String dropdownValue = "Freshman";

  _getYearData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(uid).get().then((result) {
      user.year = result["year"].toString();
      _currentYear = result["year"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("user year: " + user.year);
    //print("drop value: " + dropdownValue);
    /*return DropdownButton<String>(
      value: dropdownValue,
      //icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.grey, fontSize: 24),
      underline: Container(
        height: 3,
        color: const Color(0xFFF99E3E),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Freshman', 'Sophomore', 'Junior', 'Senior']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );*/

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
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _getYearData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {}
              return DropdownButton<String>(
                value: user.year,
                //icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.grey, fontSize: 24),
                underline: Container(
                  height: 3,
                  color: const Color(0xFFF99E3E),
                ),
                onChanged: (String newValue) async {
                  user.year = newValue;
                  setState(() {
                    print("new value: " + newValue);
                    dropdownValue = newValue;
                    _currentYear = newValue;
                    //print("_currentYear: " + _currentYear);
                    print(_getCurrentYear());
                  });
                  final uid = await Provider.of(context).auth.getCurrentUID();
                  await Provider.of(context)
                      .db
                      .collection('userData')
                      .doc(uid)
                      .update({"year": dropdownValue});
                  print("user year: " + user.year);
                },
                items: <String>['freshman', 'sophomore', 'junior', 'senior']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
      ],
    );
  }
}
