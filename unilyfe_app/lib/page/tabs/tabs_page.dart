
import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/incentives_button.dart';
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
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              for (final tabItem in TabNavigationItem.items) tabItem.page,
            ],
          ),

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
              'About Us',
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
            },
          ),
          ListTile(
            title: Text(
              'COVID Map Legend',
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
                MaterialPageRoute(builder: (context) => COVIDLegend()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Incentives',
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
                MaterialPageRoute(builder: (context) => IncentivesPage()),
              );
            },
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpTab()),
              );
            },
          ),
           ListTile(
            title: Text(
              'FAQ',
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
                MaterialPageRoute(builder: (context) => FAQTab()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Profile Awards',
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
                MaterialPageRoute(builder: (context) => StickersRules()),
              );
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
    var c_width = MediaQuery.of(context).size.width;

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
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'Carolyn Chen: ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'I enjoy hunting for squishmallows and eating the cookies from safeway with the pink frosting.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Isha Jain : ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'I enjoy eating food, playing the piano, and watching Desperate Housewives.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Ramitha Kotarkonda : ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'I enjoy dancing and playing tennis in my free time (and ofc yoga!).',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Unnati Singh : ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'I like food, music, and am desperately in need of a roommate for next year!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Gayathri Sriram : ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'I enjoy art, tiktok, listening to music, watching movies, and hanging out with my friends!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class AboutApp extends StatelessWidget {
  Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  @override
  Widget build(BuildContext context) {
    var c_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'About the App',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'About the App\n',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The recent outbreak of COVID-19 has undoubtedly transformed everyday life - the shift from regular '
                'college campus life to a fully online or hybrid experience has left students feeling disconnected from '
                'their peers and their university campus. With UniLyfe, students can make the best use of their campus '
                'by choosing to eat, study, or have fun in places that are recommended highly by their peers. While '
                'there are other existing online review applications such as Yelp or Tripadvisor, none of them are '
                'geared solely towards college students. UniLyfe will stand out because of its ability to provide '
                'personalized recommendations for locations on university campuses.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class PointsRules extends StatelessWidget {
  Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  @override
  Widget build(BuildContext context) {
    var c_width = MediaQuery.of(context).size.width;
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
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'Point System Rules',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'You will earn 10 points for posting a text post detailing your experience at a place. You will earn 5 points for commenting on a friends post!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class StickersRules extends StatelessWidget {
  Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  @override
  Widget build(BuildContext context) {
    var c_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Awards System Rules',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'Awards System Rules',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'For every 100 points you earn, you will get 1 award on your profile!\nVisit the Points System page to find out how to earn more points.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class COVIDLegend extends StatelessWidget {
  Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var c_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'COVID Tracker Legend',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body:
            /* Container (
      padding: const EdgeInsets.all(32.0),
      width: c_width,
      child: Column (
        children: <Widget>[
          Text('COVID Tracker Legend', textAlign: TextAlign.left,
          style: const TextStyle(
          fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                ),
         Text('if there are 0 people infected, there will not be a location pin there.', textAlign: TextAlign.center,
          style: const TextStyle(
          fontFamily: 'Raleway',
                color: Colors.grey,
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                ),
                ),
        ],
      ),
    ), */
            Container(
          height: 450.0,
          width: 450.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/covid_key.jpg'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.rectangle,
          ),
        ));
  }
}

// ignore: must_be_immutable
class IncentivesPage extends StatelessWidget {
  Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  @override
  Widget build(BuildContext context) {
    var c_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Incentives',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'Rules: If you have enough points specified for the rewards below, you can redeem them by clicking the Redeem button, and your points will be decreased by that number.\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //_displayPoints();
              Text(
                'Click here to redeem a free Chipotle meal!\n Cost: 10 points',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IncentivesButton()
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class HelpTab extends StatelessWidget {
  Widget pad = Container(
    padding: const EdgeInsets.all(16),
  );

  @override
  Widget build(BuildContext context) {
    var c_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Help',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'User\'s Guide to UniLyfe\n',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Once the user opens the app, they are prompted to either sign in or sign up. '
                'The user is able to sign in or sign up with their Google account or Purdue email. '
                'If the user is signing in for the first time, they are taken to a page where they can input their username, display name, and biography for their user profile. '
                'The user is then directed to the feed page where they can see all the posts made by their fellow peers. '
                'The user is also able to filter the posts they want to see. For example, they can see only food posts by clicking on the \'food tab\'. Each page includes an information button if you wish to learn more. '
                'The user can like a post by clicking on the like button. They can view all their liked posts by clicking on the liked tab located on the top of the app. '
                'To create a post, the user presses on the create button located in the bottom center of the app. '
                'They can choose to post a paul post, text post, or image post. '
                'The user can also edit elements of their user profile by clicking on the \'me\' button located in the bottom right corner of the app and clicking on \'edit profile\' located in the top right corner of the app. ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

class FAQTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double c_width = MediaQuery.of(context).size.width * 0.9;
    var c_width = MediaQuery.of(context).size.width;

    Widget pad = Container(
      padding: const EdgeInsets.all(16),
    );
    //var c_width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Freqently Asked Questions',
            style: TextStyle(color: Colors.grey),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'Question 1: How do I choose what category to label the post I create?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Answer: When you click on the \'+\' to create a post, you are able to categorize that post as \'food\', \'study\', or \'social\' by selecting the corresponding button.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Question 2: How can I get more information about the subpage that I am currently in?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Answer: Click on the orange information button located in the top left corner of the page.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Question 3: How can I report a post if I find its contents harmful?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Answer: Located in the top right corner of every post are three vertical dots. When you click on these dots, you can report a post. You can also specify the reason for reporting the post.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              pad,
              Text(
                'Question 4: How do I edit certain elements of my user profile?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Answer: Click on the \'me\' button located in the bottom right corner of the app. Click on the \'edit profile\' button located in the top right corner of the page. Here you can edit your display name, username, and/or biography. ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}


