import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/tabs/models/tab_navigation_item.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

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
          drawer: myDrawer(context),
          appBar: AppBar(
            leading: IconButton(
              color: Colors.grey,
              icon: Icon(Icons.reorder),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await Provider.of(context).auth.signOut();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(
                      Icons.logout,
                      size: 26.0,
                      color: Colors.grey,
                    ),
                  )),
            ],
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
          body: IndexedStack(
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

          bottomNavigationBar: BottomNavigationBar(
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
        ));
  }

  Widget myDrawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              'assets/unilyfe_logo.png',
              width: 20,
            ),
          ),
          ListTile(
            title: Text(
              'Help',
              style: const TextStyle(
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
            title: Text(
              'About the app',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutApp()),
              );
            },
          ),
          ListTile(
            title: Text(
              'About the creators',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
              print('here');
              //SearchPage();
            },
          ),
          ListTile(
            title: Text(
              'Point System',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PointsRules()),
              );
              print('here');
              //SearchPage();
            },
          ),
        ],
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // double c_width = MediaQuery.of(context).size.width * 0.9;
    double c_width = MediaQuery.of(context).size.width;

    Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );
    //var c_width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'About Us',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body:
   Container (
      padding: const EdgeInsets.all(32.0),
      width: c_width,
      child: Column (
        children: <Widget>[
          Text("Carolyn Chen: ", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),
         Text("I enjoy hunting for squishmallows and eating the cookies from safeway with the pink frosting.", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
              ),
                pad,
          Text("Isha Jain : ", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),  
         Text("I enjoy eating food, playing the piano, and watching Desperate Housewives.", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),   
                pad,            
           Text("Ramitha Kotarkonda : ", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
          ),
           ),
         Text("I enjoy dancing and playing tennis in my free time (and ofc yoga!).", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),
                pad,
           Text("Unnati Singh : ", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),  
         Text("I like food, music, and am desperately in need of a roommate for next year!", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ), 
                pad, 
           Text("Gayathri Sriram : ", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),   
         Text("I enjoy art, tiktok, listening to music, watching movies, and hanging out with my friends!", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),       
        ],
      ),
    )
    );
  }
}


class AboutApp extends StatelessWidget {
  @override

    Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  Widget build(BuildContext context) {
     double c_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          "About the App",
          style: TextStyle(color: Colors.grey),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
      ),
      body: 
   Container (
      padding: const EdgeInsets.all(32.0),
      width: c_width,
      child: Column (
        children: <Widget>[
          Text("About the App", textAlign: TextAlign.left,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),
         Text("The recent outbreak of COVID-19 has undoubtedly transformed everyday life - the shift from regular " +
          "college campus life to a fully online or hybrid experience has left students feeling disconnected from " +
          "their peers and their university campus. With UniLyfe, students can make the best use of their campus " +
           "by choosing to eat, study, or have fun in places that are recommended highly by their peers. While " +
           "there are other existing online review applications such as Yelp or Tripadvisor, none of them are " +
          "geared solely towards college students. UniLyfe will stand out because of its ability to provide " +
           "personalized recommendations for locations on university campuses.", textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),
        ],
      ),
    )
    );
  }
}

class PointsRules extends StatelessWidget {
  @override

    Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  Widget build(BuildContext context) {
     double c_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          'Point System Rules',
          style: TextStyle(color: Colors.grey),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
      ),
      body: 
   Container (
      padding: const EdgeInsets.all(32.0),
      width: c_width,
      child: Column (
        children: <Widget>[
          Text('Point System Rules', textAlign: TextAlign.left,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),
         Text('You will earn 5 points for posting a text post detailing your experience at a place.', textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                ),
                ),
        ],
      ),
    )
    );
  }
}

