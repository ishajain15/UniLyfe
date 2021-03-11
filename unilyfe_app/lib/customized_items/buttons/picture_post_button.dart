import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/create_posts/image_picker.dart';
// //import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// //import 'package:unilyfe_app/page/start_page.dart';
// import 'package:unilyfe_app/page/tabs/tabs_page.dart';

class PictureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Create a post with picture',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
