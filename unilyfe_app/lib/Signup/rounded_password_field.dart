import 'package:flutter/material.dart';

// import 'package:unilyfe_app/Signup/constants.dart';
import 'package:unilyfe_app/Signup/text_field_container.dart';
class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Color(0xFFF46C6B),
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Color(0xFFF46C6B),
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFFF46C6B),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
