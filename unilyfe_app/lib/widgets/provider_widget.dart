import 'package:unilyfe_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final db;
  // ignore: sort_constructors_first
  Provider({
    Key key,
    Widget child,
    this.auth,
    this.db
  }) : super(key: key, child: child);
  
  final AuthProvider auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType());
}
