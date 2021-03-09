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
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
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
          /*Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),*/
          child,
        ],
      ),
    );
  }
}
