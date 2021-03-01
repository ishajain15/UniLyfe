import 'package:flutter/material.dart';
//import 'package:unilyfe_app/buttons/logout_button.dart';
//import 'package:unilyfe_app/provider/google_sign_in.dart';



class UserProfilePage extends StatelessWidget {
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
}