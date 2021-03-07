import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unilyfe_app/provider/auth_provider.dart';
import 'package:unilyfe_app/views/sign_up_view.dart';

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
  Widget build(BuildContext context) => Provider(
        auth: AuthProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
              primaryColor: Color(0xFFF46C6B),
              scaffoldBackgroundColor: Colors.white),
          home: StartPage(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) => SignUpView(
                  authFormType: AuthFormType.signUp,
                ),
            '/signIn': (BuildContext context) => SignUpView(
                  authFormType: AuthFormType.signIn,
                ),
            '/home': (BuildContext context) => StartPage(),
          },
        ),
      );
}
