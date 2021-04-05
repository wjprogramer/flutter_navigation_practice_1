import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/navigation/my_route_information_parser.dart';
import 'package:flutter_navigation_practice_1/navigation/my_router_delegate.dart';

class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {

  final _routerDelegate = MyRouterDelegate();
  final _routeInformationParser = MyRouteInformationParser();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}