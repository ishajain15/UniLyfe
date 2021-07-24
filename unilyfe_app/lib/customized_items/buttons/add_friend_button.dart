import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFriendButton extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Add Friend!',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}