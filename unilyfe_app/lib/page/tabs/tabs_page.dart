import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/tabs/models/tab_navigation_item.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
        key: _scaffoldKey,
        drawer: myDrawer,
          appBar: AppBar(
            leading: IconButton(
              color: Colors.grey,
              icon: Icon(Icons.reorder),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            title:
                Image.asset('assets/unilyfe_logo.png', width: 300, height: 55),
            backgroundColor: const Color(0xFFFFFFFF),
            /*bottom: TabBar(
              labelColor: const Color(0xFFF56D6B),
              tabs: [
                Tab(text: "ALL"),
                Tab(text: "FOOD"),
                Tab(text: "STUDY"),
                Tab(text: "SOCIAL"),
              ],
              unselectedLabelColor: Colors.grey,
            ),*/
          ),
          body: 
          IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              for (final tabItem in TabNavigationItem.items) tabItem.page,
            ],
          ),
          
          /*TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),*/
          
          bottomNavigationBar: 
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (int index) => setState(() => _currentIndex = index),
            items: <BottomNavigationBarItem>[
              for (final tabItem in TabNavigationItem.items)
                BottomNavigationBarItem(
                  icon: tabItem.icon,
                  // ignore: deprecated_member_use
                  title: tabItem.title,
                ),
            ],
            selectedItemColor: const Color(0xfff99e3e),
          ),

        )
    );
  }

Widget myDrawer =
  Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Image.asset('assets/unilyfe_logo.png', width: 20,),
        ),
        ListTile(
          title: Text('Account Information',
          style : const TextStyle (
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: 'Raleway',
            fontSize: 17,
            ),
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Help',
          style : const TextStyle (
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: 'Raleway',
            fontSize: 17,
            ),
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('About the creators',
          style : const TextStyle (
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontFamily: 'Raleway',
            fontSize: 17,
            ),
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}
