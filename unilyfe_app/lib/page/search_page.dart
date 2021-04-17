//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:unilyfe_app/views/friend_card.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:unilyfe_app/views/home_view.dart';

//import 'package:unilyfe_app/views/home_view.dart';
var titlesList = [];
final db = FirebaseFirestore.instance;

Widget realGetTitles() {
  int index = 0;
  db.collection('posts').get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      //titlesList[index] = (Text(doc['title'].toString()));
      var title = doc['title'].toString();
      var postid = doc['postid'].toString();
      var entry = title + '=' + postid;
      //titlesList.add(doc['title'].toString());
      titlesList.add(entry);
      //print(doc["title"]);
      index++;
    });
  });
}

class SearchPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    titlesList = [];
    realGetTitles();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Click on the icon to search!',
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.grey),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Text("Suggested Besties: ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
        ),
        FriendCards(),
      ], ),
      /*body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Text("Suggested Besties: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
            ),
            FriendCards(),
          ],
        )*/

      /*body: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }),
      drawer: Drawer(),*/
    );
    /*appBar: AppBar(
         backgroundColor: const Color(0x54fdeadb),
      ),*/
  }
}

class DataSearch extends SearchDelegate<String> {
  DocumentSnapshot postDocument;

  getPost(postid) async {
    await db
        .collection('posts')
        .doc(postid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //return HomeView().buildPostCard(context, documentSnapshot);
        //print('post title: ' + documentSnapshot['title'].toString());
        postDocument = documentSnapshot;
      }
    });
  }

  generatePost(context, snapshot, postid) {
    return FutureBuilder(
        future: getPost(postid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeView().buildPostCard(context, postDocument);
          }
          return Container();
        });
  }

  final recentFlowers = [];
  String chosen = '';
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for appbar
    //realGetTitles();
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
          titlesList = [];
          realGetTitles();
        });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    //print(chosen);
    //return getPost(chosen);
    return FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return generatePost(context, snapshot, chosen);
        } else {
          return buildLoading();
        }
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentFlowers
        : titlesList.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          chosen = suggestionList[index]
              .substring(suggestionList[index].indexOf('=') + 1);
          showResults(context);
        },
        leading: Icon(Icons.beach_access),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(
                      query.length, suggestionList[index].indexOf('=')),
                  //text: suggestionList[index].substring(0, suggestionList[index].indexOf(" ")),
                  style: TextStyle(color: Colors.grey)),
              TextSpan(
                  text: suggestionList[index]
                      .substring(suggestionList[index].indexOf('=')),
                  //text: suggestionList[index].substring(0, suggestionList[index].indexOf(" ")),
                  style: TextStyle(color: Colors.white)),
            ])),
      ),
      itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }
}

class QueryTitles extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //var list = <Widget>[];
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: buildLoading());
          } else {
            return ListView(
                children: snapshot.data.docs.map((document) {
              //list.add(Text(document['title'].toString()));
              return ListTile(
                  title: Text(document['title'].toString()),
                  subtitle: Text(document['count'].toString()));
            }).toList());
          }
        });
  }
}
