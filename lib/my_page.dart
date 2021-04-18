import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'my_home_page.dart';

class MyPage extends Page {
  const MyPage({
    LocalKey key,
    String name,
  }) : super(
    key: key,
    name: name,
  );

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return MyHomePage(title: 'Route: $name');
      },
    );
  }
}