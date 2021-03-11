import 'package:flutter/material.dart';

/*class UserProfilePage extends StatelessWidget {
  int _selectedIndex = 0;
static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
static const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: Home',
    style: optionStyle,
  ),
  Text(
     'Index 1: Explore',
     style: optionStyle,
  ),
  Text(
     'Index 2: Create',
     style: optionStyle,
  ),
    Text(
    'Index 0: Corona',
    style: optionStyle,
  ),
    Text(
    'Index 0: Me',
    style: optionStyle,
  ),
];

/*void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}*/
  @override
  Widget build(BuildContext context) {

    /*return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'random stuff for now',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          //LogoutButtonWidget(),
        ],
      ),
    );*/
    return Scaffold(
    appBar: AppBar(
      title: const Text('BottomNavigationBar Sample'),
    ),
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Corona',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Me',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      //onTap: _onItemTapped,
    ),
  );
  }
}*/

class ProfilePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );

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
          'Tiktok Star',
          'Photoshop',
          'Coder' 'Simper',
          'Basic Bitch',
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
      ],
      //),
    )

        /*floatingActionButton: FloatingActionButton(
    backgroundColor: const Color(0xFFF56D6B),
    onPressed: () {},
    child: Icon(Icons.add,),
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    shape: RoundedRectangleBorder(),
    
  ),*/
        );
  }
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
            'tiktoker lol',
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

// ignore: camel_case_types
class _profilePicture extends StatefulWidget {
  @override
  _myProfilePictureState createState() => _myProfilePictureState();
}

class _myProfilePictureState extends State<_profilePicture> {
  String picture = 'assets/gayathri.png';
  void _changePicture() {
    setState(() {
      if (picture == 'assets/gayathri_armstrong.png') {
        picture = 'assets/gayathri.png';
        print("new picture: " + picture);
        return;
      }
      if (picture == 'assets/gayathri.png') {
        picture = 'assets/gayathri_armstrong.png';
        print("new picture: " + picture);
        return;
      }
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _changePicture();
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
}

Widget _changeInfo(String textBoxText) {
  return 
    TextField(
    autofocus: false,
    style: TextStyle(fontSize: 22.0, color: Colors.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0xFFfae9d7),
      hintText: textBoxText,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
              _changeInfo("change username..."),
              Container(
                padding: const EdgeInsets.all(16),
              ),
              _changeInfo("change name..."),
              Container(
                padding: const EdgeInsets.all(16),
              ),
              _changeInfo("change bio..."),
              Container(
                padding: const EdgeInsets.all(16),
              ),
              _changeInfo("change profile pic..."),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Submit'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  )
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
