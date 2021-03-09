import 'package:flutter/material.dart';

class CoronaPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CoronaPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ayo its coronatime'),
      ),
    );
  }
}
