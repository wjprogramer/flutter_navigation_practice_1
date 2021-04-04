import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_providers.dart';

void main() {
  runApp(MultiProvider(
    providers: getProviders(),
    child: BooksApp(),
  ));
}
