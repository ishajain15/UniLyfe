import 'package:flutter/material.dart';
import 'package:unilyfe_app/Signup/rounded_button.dart';
import 'package:unilyfe_app/Signup/text_field_container.dart';
import 'package:unilyfe_app/provider/auth_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

final primaryColor = const Color(0xFFFFFFFF);

enum AuthFormType { signIn, signUp }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;
  SignUpView({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
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
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed in with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _name);
          print("Signed up with New ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
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
    Size size = MediaQuery.of(context).size * 2;

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
                SizedBox(height: _height * 0.0025),
                //buildHeaderText(),
                // Positioned(
                //   top: 200,
                //   left: 65,
                //   child: Image.asset(
                //     "assets/unilyfe_logo.png",
                //     width: size.width * 0.35,
                //   ),
                // ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                    child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                  ),
                ),
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
        color: Colors.amberAccent,
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

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Sign Up";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    // if were in the sign up state and add name
    // JUST ADDING THIS FOR NOW, NEED TO CHANGE LATER SINCE WE WILL HAVE A SEPARATE PAGE
    if (authFormType == AuthFormType.signUp) {
      textFields.add(TextFieldContainer(
          child: TextFormField(
        validator: NameValidator.validate,
        decoration: buildSignUpInputDecoration(
            "Name",
            Icon(
              Icons.person,
              color: Color(0xFFF46C6B),
            ),
            false),
        onSaved: (value) => _name = value,
      )));
      textFields.add(SizedBox(
        height: 10,
      ));
    }

    // add email & password
    textFields.add(TextFieldContainer(
      child: TextFormField(
        validator: EmailValidator.validate,
        decoration: buildSignUpInputDecoration(
            "Email",
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
            "Password",
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
    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "SIGN IN";
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "SIGN UP";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        // child: ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30.0)),
        //     primary: Colors.orange,
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child:
        //         Text(_submitButtonText, style: TextStyle(color: Colors.white)),
        //   ),
        //   onPressed: submit,
        // ),
        child: RoundedButton(
          text: _submitButtonText,
          press: submit,
        ),
      ),
      TextButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }
}
