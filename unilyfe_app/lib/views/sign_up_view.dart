import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/rounded_button.dart';
import 'package:unilyfe_app/customized_items/text_field_container.dart';
import 'package:unilyfe_app/customized_items/buttons/google_button.dart';
import 'package:unilyfe_app/provider/auth_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
//import 'dart:math' as math;

final primaryColor = const Color(0xFFFFFFFF);

enum AuthFormType { signIn, signUp, reset }

class SignUpView extends StatefulWidget {
  SignUpView({Key key, @required this.authFormType}) : super(key: key);
  final AuthFormType authFormType;
  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  _SignUpViewState({this.authFormType});
  AuthFormType authFormType;

  final formKey = GlobalKey<FormState>();
  String _email, _password, /*_name,*/ _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    // var num = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    // print(num);
    // print(Color(num).withOpacity(1.0));
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          //return buildLoading();
          var uid = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in with ID $uid');
          await Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print('Password reset email sent');
          _error = 'A password reset link has been sent to $_email';
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          var uid = await auth.createUserWithEmailAndPassword(
            _email,
            _password, /*_name*/
          );
          await auth.createUserInFirestore();
          await auth.sendEmailVerification();
          print('Signed up with New ID $uid');
          // await Provider.of(context)
          //     .db
          //     .collection('userData')
          //     .doc(uid)
          //     .update({'name': _name});
          // do random color here
          // var num = (math.Random().nextDouble() * 0xFFFFFF).toInt();
          // await Provider.of(context)
          //     .db
          //     .collection('userData')
          //     .doc(uid)
          //     .update({'color_code': num});
          await Navigator.of(context).pushReplacementNamed('/home');
          //logout button does not work if this is used
          //new plan to make the email verification useful: generate random username
          //users can only change their username if their email has been verified
          //username page will now only be in edit bio location.
          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UsernamePage()));
        }
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.0025),
                showAlert(),
                SizedBox(height: _height * 0.14),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: _width * 0.06),
                    child: Image.asset('assets/unilyfe_logo.png',
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: _height * 0.025),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: buildInputs() + buildButtons(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Color(0xFFfae9d7),
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  List<Widget> buildInputs() {
    var textFields = <Widget>[];

    if (authFormType == AuthFormType.reset) {
      textFields.add(TextFieldContainer(
          child: TextFormField(
        validator: EmailValidator.validate,
        decoration: buildSignUpInputDecoration(
            'Email',
            Icon(
              Icons.email,
              color: Color(0xFFF46C6B),
            ),
            false),
        onSaved: (value) => _email = value,
      )));
      textFields.add(SizedBox(
        height: 10,
      ));
      return textFields;
    }

    // add email & password
    textFields.add(TextFieldContainer(
      child: TextFormField(
        validator: EmailValidator.validate,
        decoration: buildSignUpInputDecoration(
            'Email',
            Icon(
              Icons.email,
              color: Color(0xFFF46C6B),
            ),
            false),
        onSaved: (value) => _email = value,
      ),
    ));

    textFields.add(SizedBox(
      height: 10,
    ));

    textFields.add(TextFieldContainer(
      child: TextFormField(
        validator: PasswordValidator.validate,
        decoration: buildSignUpInputDecoration(
            'Password',
            Icon(
              Icons.lock,
              color: Color(0xFFF46C6B),
            ),
            true),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    ));

    textFields.add(SizedBox(
      height: 10,
    ));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(
      String hint, Icon icon, bool password) {
    if (password) {
      return InputDecoration(
        icon: icon,
        suffixIcon: Icon(
          Icons.visibility,
          color: Color(0xFFF46C6B),
        ),
        hintText: hint,
        border: InputBorder.none,
      );
    } else {
      return InputDecoration(
        icon: icon,
        hintText: hint,
        border: InputBorder.none,
      );
    }
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    var _showForgotPassword = false;
    var _showGoogle = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = 'CREATE NEW ACCOUNT';
      _newFormState = 'signUp';
      _submitButtonText = 'SIGN IN';
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = 'RETURN TO SIGN IN';
      _newFormState = 'signIn';
      _submitButtonText = 'SUBMIT';
      _showGoogle = false;
    } else {
      _switchButtonText = 'HAVE AN ACCOUNT? SIGN IN';
      _newFormState = 'signIn';
      _submitButtonText = 'SIGN UP';
    }

    return [
      Container(
        child: RoundedButton(
          text: _submitButtonText,
          press: submit,
        ),
      ),
      showForgotPassword(_showForgotPassword),
      TextButton(
        onPressed: () {
          switchFormState(_newFormState);
        },
        child: Text(
          _switchButtonText,
          style:
              TextStyle(color: Color(0xFFF47C54), fontWeight: FontWeight.bold),
        ),
      ),
      buildGoogleButton(_showGoogle)
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      visible: visible,
      child: TextButton(
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
        child: Text(
          'FORGOT PASSWORD?',
          style:
              TextStyle(color: Color(0xFFF47C54), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildGoogleButton(bool visible) {
    final _auth = Provider.of(context).auth;
    return Visibility(
      visible: visible,
      child: Column(
        children: <Widget>[
          Divider(color: Color(0xFFF46C6B)),
          SizedBox(height: 5),
          GoogleButtonWidget(
            press: () async {
              try {
                await _auth.signInWithGoogle();
                await _auth.createUserInFirestore();
                // var num = (math.Random().nextDouble() * 0xFFFFFF).toInt();
                // var uid = await _auth.getCurrentUID();
                // await Provider.of(context)
                //     .db
                //     .collection('userData')
                //     .doc(uid)
                //     .update({'color_code': num});
                await Navigator.of(context).pushReplacementNamed('/home');
              } catch (e) {
                setState(() {
                  _error = e.message;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
