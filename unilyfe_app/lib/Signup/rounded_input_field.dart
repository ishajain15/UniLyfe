import 'package:flutter/material.dart';

import 'package:unilyfe_app/Signup/text_field_container.dart';
// import 'package:unilyfe_app/Signup/constants.dart';
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Color(0xFFF46C6B),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFFF46C6B),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
