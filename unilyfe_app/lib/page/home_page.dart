import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/views/food_view.dart';
import 'package:unilyfe_app/views/home_view.dart';
import 'package:unilyfe_app/views/review_view.dart';
import 'package:unilyfe_app/views/social_view.dart';
import 'package:unilyfe_app/views/study_view.dart';

class HomePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final user = FirebaseAuth.instance.currentUser;
    

    return DefaultTabController(
      length: 5,
      child: Scaffold(
      
      appBar: TabBar(
        labelColor: const Color(0xFFF56D6B),
        tabs: [
          Tab(text: 'ALL'),
          Tab(text: 'FOOD'),
          Tab(text: 'STUDY'),
          Tab(text: 'SOCIAL'),
          Tab(text: 'REVIEWS')
        ],
        unselectedLabelColor: Colors.grey,
      ),
      
      //),
      body: TabBarView(
        children: [
          //Icon(Icons.directions_car),
          //Text('feedfeedfeed', textAlign: TextAlign.center,),
          //Posts(),
          HomeViewState(),
          FoodViewState(),
          StudyViewState(),
          SocialViewState(),
          ReviewViewState()
        ],
      ),
      //bottomSheet: LogoutButtonWidget(),
    ));

    /*return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
             'Welcome ' + user.displayName,
            //'Welcome ',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          LogoutButtonWidget(),
        ],
      ),
    );*/
    /*return Scaffold(
      body: Center(
        child: Text("Hello, hi!"),
      ),
    );*/
  }
}
