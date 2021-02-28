import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// testing
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final String title = 'Sign In';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: StartPage(),
      );
}
