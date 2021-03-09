import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Color(0xFFF46C6B),
        decoration: InputDecoration(
          hintText: 'Password',
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
