import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/create_posts/poll_posts.dart';
// //import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// //import 'package:unilyfe_app/page/start_page.dart';
// import 'package:unilyfe_app/page/tabs/tabs_page.dart';
// import 'package:unilyfe_app/files_to_be_deleted/register_page.dart';
// import 'package:unilyfe_app/page/create_posts/poll_form.dart';


class Pollsview extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
              Navigator.push(
            context, MaterialPageRoute(builder: (context) => PollView()));
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'view poll',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
