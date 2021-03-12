import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unilyfe_app/customized_items/buttons/back_button.dart';
import 'package:unilyfe_app/customized_items/buttons/lets_go_button.dart';
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
  User user = User("");
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _profilePictureController = TextEditingController();
  TextEditingController _covidController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  static String picture = null;

  //final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      //child: Column(
      children: <Widget>[
        //editProfileBar,
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
                _tripEditModalBottomSheet(context);
              },
              child: Text('Edit Profile'),
            ),
          ),
        ])),
        //profilePicture,
        _profilePicture(),
        userInfo,
        //titleSection,
        //chip,
        chipList([
          'Photography',
          'Tiktoker',
          'Photoshop',
          'Coder' ,
          'Chef',
          'Baker',
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
          BackButtonWidget(),
      ],

      //),
    ));
  }
//}

  String returnPicture(String picture) {
    return picture;
  }

  Widget profilePicture = Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: AssetImage('assets/gayathri.png'),
      ),
    ),
  );

  Widget userInfo = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Gayathri',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Sophomore',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Datamine',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
          ),
        ],
      ));

  Widget pad = Container(
    padding: const EdgeInsets.all(32),
    //child: Row(),
  );

/*Widget editProfileBar = Container(
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
        _tripEditModalBottomSheet(context);
      },
      child: Text('Edit Profile'),
    ),
  ),
]));*/

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

  void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Edit Profile"),
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
                    RaisedButton(
                        child: Text('Submit'),
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        onPressed: () async {
                          final uid =
                              await Provider.of(context).auth.getCurrentUID();
                          if (_usernameController.text != null) {
                            user.username = _usernameController.text;
                            print(_usernameController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }
                          if (_displayNameController.text != null) {
                            user.displayName = _displayNameController.text;
                            print(_displayNameController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }
                          if (_bioController.text != null) {
                            user.bio = _bioController.text;
                            print(_bioController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }
                          if (_profilePictureController.text != null) {
                            picture = _profilePictureController.text;
                            user.picturePath = _profilePictureController.text;
                            print(_profilePictureController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }
                          if (_covidController.text != null) {
                            user.covid = _covidController.text;
                            print(_covidController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }
                          if (_locationController.text != null) {
                            user.location = _locationController.text;
                            print(_locationController.text);
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .doc(uid)
                                .set(user.toJson());
                          }

                          Navigator.of(context).pop();
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.red,
                      textColor: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /* _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
          user.username = result.data['username'];
    });
  }*/
}

// ignore: camel_case_types
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
    String picture = null;
    if (_ProfilePageState.picture == null) {
      picture = 'assets/gayathri_armstrong.png';
    } else {
      picture = _ProfilePageState.picture;
    }
    return GestureDetector(
        onTap: () {
          //_changePicture();
          print('hello');
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(picture),
            ),
          ),
        ));
  }
  final db = FirebaseFirestore.instance;

//   Future<DocumentReference> getUserDoc() async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // final Firestore _firestore = Firestore.instance;
//   final uid = await Provider.of(context).auth.getCurrentUID();
//   DocumentReference ref = db.collection('users').doc(uid);
//   return ref;
// }
//   Future<DocumentSnapshot> getUsername() async{
//     Future<DocumentReference> ref = getUserDoc();
//     List<User> list = ref

//   }
final firestore = FirebaseFirestore.instance;   //
FirebaseAuth auth = FirebaseAuth.instance;     //recommend declaring a reference outside the methods 

// Future<String> getUserName(String username) async {
  
//   final CollectionReference users = firestore.collection('UserData');
  
//   // final String uid = auth.currentUser.uid;

//   final result = await users.doc(uid).get();
//   Future<String> str = result.data()['username'];
  
// }
getList() async {
  return await firestore.collection('userData').get().asStream();
}
Future<bool> sumStream(String username) async {
  Stream<bool> stream = getList();
  await for (var value in stream) {
    if (value == username){
      return true;
    }
   }
  return false;
}

}
