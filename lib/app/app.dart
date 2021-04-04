import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/models/book.dart';
import 'package:flutter_navigation_practice_1/navigation/book_route_information_parser.dart';
import 'package:flutter_navigation_practice_1/navigation/book_router_delegate.dart';
import 'package:flutter_navigation_practice_1/screens/book_details_screen.dart';
import 'package:flutter_navigation_practice_1/screens/book_list_screen.dart';
import 'package:flutter_navigation_practice_1/screens/unknown_screen.dart';

class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {

  final _routerDelegate = BookRouterDelegate();
  final _routeInformationParser = BookRouteInformationParser();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      // home: Navigator(
      //   pages: pages,
      //   onPopPage: onPopPage,
      // ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}