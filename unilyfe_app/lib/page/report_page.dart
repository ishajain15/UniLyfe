
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: must_be_immutable
String reason = '';
// ignore: must_be_immutable
class Report extends StatefulWidget{
  Report({Key key, @required this.postid, @required this.postChannel})
      : super(key: key);
  String postid;
  String postChannel;
  @override
  ReportState createState()=> ReportState(postid: postid, postChannel: postChannel);
}
class ReportState extends State<Report>{
  ReportState({Key key, @required this.postid, @required this.postChannel});
  String postid;
  String postChannel;
  void thankyousheet(context){
    showModalBottomSheet(context:context, builder : (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
            child: Column(
            children: <Widget>[
              IconButton( icon: Icon(Icons.check_circle_outline_sharp, color: Colors.green, size: 30), onPressed: () {  },),
             
              Text(
                'Thanks for reporting this post.',
                style: TextStyle(
                  fontSize: 20.0,
                  ),
                ),
                Text(
                'We will review this post to determine wheter it violates our Policies.',
                style: TextStyle(
                  fontSize: 20.0,
                  ),
                ),
                Text(
                'Thanks for helping us keep Unilyfe safe.',
                style: TextStyle(
                  fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
          onPressed: () async {
            setState(() {
                final db = FirebaseFirestore.instance;
                 db.collection('reported_posts').doc(postid).set({'post_channel': postChannel});
            });
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Back',
          ),
        ),
            ],
          ),
          ),
        );
    });
  }
  void reportsheet(context){
      showModalBottomSheet(context: context, builder: (BuildContext bc){
        return Container(
          height: MediaQuery.of(context).size.height * .60,
            child: Column(
            children: <Widget>[
              Text(
                'Why are you reporting this post?',
                style: TextStyle(
                  fontSize: 20.0,
                  ),
                ),
           ElevatedButton(
          onPressed: () => thankyousheet(context),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'I find it offensive',
          ),
        ),
        ElevatedButton(
          onPressed: () => thankyousheet(context),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Its spam',
          ),
        ),
        ElevatedButton(
          onPressed: () => thankyousheet(context),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Its inappropriate',
          ),
        ),
        ElevatedButton(
          onPressed: () => thankyousheet(context),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Its violent or prohibited Content',
          ),
        ),
              
            ],
        ),
          );
      });
    }
  void bottom_Sheet(context){
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      
      return Container(
        height: MediaQuery.of(context).size.height * .60,
        child: Column(
            children: <Widget>[
           ElevatedButton(
          onPressed: () => reportsheet(context),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Report',
          ),
        ),
              
            ],
        ),
      );
    });

  }
      @override
  Widget build(BuildContext context){
        return IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => bottom_Sheet(context),
        );
      }
}
