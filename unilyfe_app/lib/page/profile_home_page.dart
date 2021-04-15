import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/profile_page.dart';
import 'package:unilyfe_app/views/friends_view.dart';
import 'package:unilyfe_app/views/liked_posts_view.dart';
import 'package:unilyfe_app/views/comment_history_view.dart';
//import 'package:unilyfe_app/provider/google_sign_in.dart';
//import 'package:unilyfe_app/page/profile_page.dart';

class ProfileHomePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        //builder: (context) => HomePage(),
        builder: (context) => ProfileHomePage(),
      );
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final user = FirebaseAuth.instance.currentUser;

    //return Scaffold(
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: TabBar(
            labelColor: const Color(0xFFF56D6B),
            tabs: [
              Tab(text: 'YOU'),
              Tab(text: 'LIKED'),
              Tab(text: 'COMMENTS'),
              Tab(text: 'FRIENDS')
            ],
            unselectedLabelColor: Colors.grey,
          ),
          body: TabBarView(
            children: 
            [ProfilePage(), 
            LikedPostsView(),
            CommentHistoryView(),
            FriendsView()
            ],
          ),
        )
        //bottomSheet: LogoutButtonWidget(),
        );
  }
}
