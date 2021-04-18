import 'package:flutter/material.dart';

import 'my_page.dart';
import 'screens.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static int _counter = 15;

  // Initial Route: /category/5/item/15
  final pages = [
    MyPage(
      key: Key('/'),
      name: '/',
      builder: (context) => HomeScreen(),
    ),
    MyPage(
      key: Key('/category/5'),
      name: '/category/5',
      builder: (context) => CategoryScreen(id: 5),
    ),
    MyPage(
      key: Key('/item/15'),
      name: '/item/15',
      builder: (context) => ItemScreen(id: 15),
    ),
  ];

  void addPage(MyPage page) {
    setState(() => pages.add(page));
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    setState(() => pages.remove(route.settings));
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    print('build: pages:  $pages');

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: WillPopScope(
          onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
          child: Navigator(
            key: _navigatorKey,
            onPopPage: _onPopPage,
            pages: List.of(pages),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              final int id = ++_counter;
              pages.add(
                MyPage(
                  key: Key('/item/$id'),
                  name: '/item/$id',
                  builder: (context) => ItemScreen(id: id),
                ),
              );
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}