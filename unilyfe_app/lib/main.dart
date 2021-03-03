import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//testing
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final String title = 'UniLyfe';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primaryColor: Color(0xFFF46C6B), scaffoldBackgroundColor: Colors.white),
        home: StartPage(),
      );
}
