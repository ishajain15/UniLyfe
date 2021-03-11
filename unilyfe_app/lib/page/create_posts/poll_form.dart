import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// ignore: must_be_immutable
class PollForm extends StatelessWidget {
  // final databaseReference = FirebaseDatabase.instance.reference();

  String _question, _option1,_option2,_option3,_option4;
  Widget build(BuildContext context) {
  return new Scaffold(
    body: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Question',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_question = value.trim();},
        ),
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 1',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option1 = value.trim();},
        ),
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 2',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option2 = value.trim();},
        ),
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 3',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option3 = value.trim();},
        ),
         new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 4',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option4 = value.trim();},
        ),
        RoundedButton(
              text: 'Create Poll',
              press: () {
                userSetup();
              },
            ),
      ],
    ),
    
  );
}
}

// void createRecord(){
//     databaseReference.child("1").set({
//       'title': 'Mastering EJB',
//       'description': 'Programming Guide for J2EE'
//     });
//     databaseReference.child("2").set({
//       'title': 'Flutter in Action',
//       'description': 'Complete Programming Guide to learn Flutter'
//     });
//   }
Future<void> userSetup() async{
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  // FirebaseAuth auth = FirebaseAuth.instance;
  users.add({'text': 'hi, please work'});
  return;
}
