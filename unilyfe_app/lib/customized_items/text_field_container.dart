import 'package:flutter/material.dart';
// import 'package:unilyfe_app/Signup/constants.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xFFfae9d7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
