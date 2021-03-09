import 'package:flutter/material.dart';

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
        onPressed: () {},
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        shape: RoundedRectangleBorder(),
        child: Icon(Icons.add,),
  ),
    );
  }
}
