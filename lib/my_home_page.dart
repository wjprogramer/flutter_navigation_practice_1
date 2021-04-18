import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'my_page_route_delegate.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int _counter = 0;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Is this being displayed?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('NO'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('YES'),
            ),
          ],
        );
      },
    );
  }

  void _removeLast() {
    final delegate = MyRouteDelegate.of(context);
    final stack = delegate.stack;
    if (stack.length > 2) {
      delegate.remove(stack[stack.length - 2]);
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    MyRouteDelegate.of(context).push('Route$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'dialog',
            onPressed: _showDialog,
            tooltip: 'Show dialog',
            child: Icon(Icons.message),
          ),
          SizedBox(width: 12.0),
          FloatingActionButton(
            heroTag: 'remove',
            onPressed: _removeLast,
            tooltip: 'Remove last',
            child: Icon(Icons.delete),
          ),
          SizedBox(width: 12.0),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}