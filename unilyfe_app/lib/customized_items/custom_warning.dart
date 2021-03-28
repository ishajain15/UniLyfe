import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.backgroundColor = Colors.white,
    this.firstText,
    this.secondText,
    this.onFirstPressed,
    this.onSecondPressed,
  })  : assert(backgroundColor != null),
        assert(circularBorderRadius != null);

  final Color backgroundColor;
  final String title;
  final String message;
  final String firstText;
  final String secondText;
  final Function onFirstPressed;
  final Function onSecondPressed;
  final double circularBorderRadius;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        secondText != null
            ? TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onSecondPressed != null) {
                    onSecondPressed();
                  }
                },
                child: Text(secondText),
              )
            : null,
        firstText != null
            ? TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  if (onFirstPressed != null) {
                    onFirstPressed();
                  }
                },
                child: Text(firstText),
              )
            : null,
      ],
    );
  }
}
