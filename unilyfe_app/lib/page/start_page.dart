//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:unilyfe_app/Signup/rounded_button.dart';
//import 'package:unilyfe_app/buttons/google_button.dart';
import 'package:unilyfe_app/buttons/sign_in_button.dart';
import 'package:unilyfe_app/buttons/sign_up_button.dart';
//import 'package:unilyfe_app/loaders/color_loader_4.dart';
//import 'package:unilyfe_app/loaders/dot_type.dart';
//import 'package:unilyfe_app/provider/google_sign_in.dart';
//import 'package:unilyfe_app/page/home_page.dart';
//import 'package:unilyfe_app/page/tabs/tabs_page.dart';
//import 'package:unilyfe_app/widgets/start_widget.dart';
//import 'package:provider/provider.dart';
//import 'package:unilyfe_app/provider/auth_provider.dart';
//import 'package:auto_size_text/auto_size_text.dart';

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
  final primaryColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.02,
                ),
                Align(
                  //alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                    child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: _height * 0.04,
                ),
                SignInButtonWidget(),
                SizedBox(
                  height: _height * 0.01,
                ),
                SignUpButtonWidget(),
                SizedBox(
                  height: _height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
