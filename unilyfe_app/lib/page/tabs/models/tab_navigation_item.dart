import 'package:flutter/material.dart';
import 'package:unilyfe_app/my_flutter_app_icons.dart';
import 'package:unilyfe_app/page/home_page.dart';
import 'package:unilyfe_app/page/search_page.dart';
import 'package:unilyfe_app/page/create_page.dart';
import 'package:unilyfe_app/page/corona_page.dart';
import 'package:unilyfe_app/page/profile_page.dart';



class TabNavigationItem {
  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  final Widget page;
  final Widget title;
  final Icon icon;

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(MyFlutterApp.home_unilyfe),
          title: Text('Home'),
        ),
        TabNavigationItem(
          page: SearchPage(),
          icon: Icon(MyFlutterApp.search_unilyfe),
          title: Text('Search'),
        ),
        TabNavigationItem(
          page: CreatePage(),
          icon: Icon(MyFlutterApp.plus_unilyfe),
          title: Text('Create'),
        ),
        TabNavigationItem(
          //page: CoronaPage(),
          page: MyMap(),
          icon: Icon(MyFlutterApp.corona_unilyfe),
          title: Text('Corona'),
        ),
        TabNavigationItem(
          page: ProfilePage(),
          icon: Icon(MyFlutterApp.profile_unilyfe),
          title: Text('Me'),
        )
      ];
}