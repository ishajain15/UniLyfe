import 'package:flutter/material.dart';



class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size*2;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 130,
            left: 60,
            child: Image.asset(
              "assets/unilyfe_logo.png",
              width: size.width * 0.35,
            ),
          ),
         /* Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),*/
          child,
        ],
      ),
    );
  }
}
