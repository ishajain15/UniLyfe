import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/loaders/color_loader_4.dart';
import 'package:unilyfe_app/loaders/dot_type.dart';
import 'package:unilyfe_app/provider/google_sign_in.dart';
//import 'package:unilyfe_app/page/home_page.dart';
import 'package:unilyfe_app/page/tabs/tabs_page.dart';
import 'package:unilyfe_app/widgets/start_widget.dart';
import 'package:provider/provider.dart';
import 'package:unilyfe_app/provider/auth_provider.dart';

/*class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                //return HomePage();
                return TabsPage();
              } else {
                return StartWidget();
              }
            },
          ),
        ),
      );
}
*/

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? TabsPage() : StartWidget();
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
