import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncentivesButton extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () async {
            final auth = Provider.of(context).auth;
            auth.setNewUser(false);
            await Navigator.of(context).pushReplacementNamed('/home');
            var  current_uid = await Provider.of(context).auth.getCurrentUID();
            await db.collection('userData').doc(current_uid).update({'points_field': FieldValue.increment(-10)});
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Redeem',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
