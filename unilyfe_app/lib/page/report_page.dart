import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
String reason = '';

// ignore: must_be_immutable
class Report extends StatefulWidget {
  Report({Key key, @required this.postid, @required this.postChannel, this.reported})
      : super(key: key);
  String postid;
  String postChannel;
  int reported;
  @override
  ReportState createState() =>
      ReportState(postid: postid, postChannel: postChannel, reported:reported);
}

class ReportState extends State<Report> {
  ReportState({Key key, @required this.postid, @required this.postChannel, this.reported});
  String postid;
  String postChannel;
  
  int reported;
  void thankyousheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check_circle_outline_sharp,
                        color: Colors.green, size: 30),
                    onPressed: () {},
                  ),
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
                        String postCollection = '';

                        if (postChannel == 'FOOD') {
                          postCollection = 'food_posts';
                        } else if (postChannel == 'STUDY') {
                          postCollection = 'study_posts';
                        } else {
                          postCollection = 'social_posts';
                        }
                        
                        final db = FirebaseFirestore.instance;
                        reported++;
                        db
                            .collection('reported_posts')
                            .doc(postid)
                            .set({'reported': reported});
                        if(reported > 2) {
                           db
                            .collection('developer_posts')
                            .doc(postid)
                            .set({'reported': reported});
                            db.collection("posts").doc(postid).delete();
                            db.collection(postCollection).doc(postid).delete();
                        }
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
    void thankyousheetUser(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check_circle_outline_sharp,
                        color: Colors.green, size: 30),
                    onPressed: () {},
                  ),
                  Text(
                    'Thanks for reporting this user.',
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
                        String postCollection = '';

                        if (postChannel == 'FOOD') {
                          postCollection = 'food_posts';
                        } else if (postChannel == 'STUDY') {
                          postCollection = 'study_posts';
                        } else {
                          postCollection = 'social_posts';
                        }
                        
                        final db = FirebaseFirestore.instance;
                        reported++;
                        db
                            .collection('reported_user')
                            .doc(postid)
                            .set({'reported': reported});
                        if(reported > 2) {
                           db
                            .collection('developer_posts')
                            .doc(postid)
                            .set({'reported': reported});
                            db.collection("posts").doc(postid).delete();
                            db.collection(postCollection).doc(postid).delete();
                        }
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
  void reportsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
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

void reportUsersheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: <Widget>[
                Text(
                  'Why are you reporting this user?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
               
                ElevatedButton(
                  onPressed: () => thankyousheetUser(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF46C6B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'This user posted content which is offensive',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => thankyousheetUser(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF46C6B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'This user posted content which is inappropriate',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => thankyousheetUser(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF46C6B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'This user posted content which is  violent or prohibited',
                  ),
                ),
              ],
            ),
          );
        });
  }


  void bottom_Sheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: <Widget>[
                Container(
                  width: 400.0,
                  // height: 120.0,
                  child: ElevatedButton(
                  onPressed: () => reportsheet(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF46C6B),
                    onPrimary: Colors.white,
                    
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'Report Post',
                  ),
                ),
                ),
              
                Container(
                width: 400.0,
                child: ElevatedButton(
                  onPressed: () => reportUsersheet(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF99E3E),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'Report User',
                  ),
                ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      color: Colors.grey[500],
      onPressed: () => bottom_Sheet(context),
    );
  }
}
