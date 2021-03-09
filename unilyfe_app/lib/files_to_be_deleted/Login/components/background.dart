import 'package:flutter/material.dart';



class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size*2;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 200,
            left: 65,
            child: Image.asset(
              'assets/unilyfe_logo.png',
              width: size.width * 0.35,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
