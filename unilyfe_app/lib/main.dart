import 'package:flutter/material.dart';
import 'package:unilyfe_app/loaders/color_loader_4.dart';
import 'package:unilyfe_app/loaders/dot_type.dart';
import 'package:unilyfe_app/page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unilyfe_app/page/tabs/tabs_page.dart';
import 'package:unilyfe_app/provider/auth_provider.dart';
import 'package:unilyfe_app/views/sign_up_view.dart';
import 'package:unilyfe_app/widgets/start_widget.dart';

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

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? TabsPage() : StartPage();
        }
        return buildLoading();
      },
    );
  }
}

class Provider extends InheritedWidget {
  final AuthProvider auth;
  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType() as Provider);
}

//Widget buildLoading() => Center(child: ColorLoader3());
Widget buildLoading() => Center(
        child: ColorLoader4(
      dotOneColor: Color(0xFFF46C6B),
      dotTwoColor: Color(0xFFF47C54),
      dotThreeColor: Color(0xFFFCAC54),
      dotType: DotType.square,
      duration: Duration(milliseconds: 1200),
    ));
