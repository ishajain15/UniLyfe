import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/create_posts/options_page.dart';
class CreatePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CreatePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello, create page!'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF56D6B),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Options()));
        },
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        shape: RoundedRectangleBorder(),
        child: Icon(Icons.add,),
  ),
    );
  }
}
