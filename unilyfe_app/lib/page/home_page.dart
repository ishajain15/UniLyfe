import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/buttons/logout_button.dart';
import 'package:unilyfe_app/provider/google_sign_in.dart';
import 'package:unilyfe_app/page/profile_page.dart';

class HomePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

      return Scaffold(
      appBar: 
        TabBar(
          labelColor: const Color(0xFFF56D6B),
          tabs: [
            Tab(text: "ALL"),
            Tab(text: "FOOD"),
            Tab(text: "STUDY"),
            Tab(text: "SOCIAL"),
          ],
          unselectedLabelColor: Colors.grey,
        ),
      //),
      body: TabBarView(
        children: [
          //Icon(Icons.directions_car),
          Text("feedfeedfeed", textAlign: TextAlign.center,),
          Text("yummy nomnom", textAlign: TextAlign.center,),
          Text("studywuddy", textAlign: TextAlign.center,),
          Text("fun fun fun", textAlign: TextAlign.center,),
        ],
      ),
      bottomSheet: LogoutButtonWidget(),
      
    );

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
