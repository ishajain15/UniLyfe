import 'package:unilyfe_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final AuthProvider auth;
  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType());
}
