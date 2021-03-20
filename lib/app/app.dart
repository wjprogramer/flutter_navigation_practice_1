import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/models/book.dart';
import 'package:flutter_navigation_practice_1/screens/book_details_screen.dart';
import 'package:flutter_navigation_practice_1/screens/book_list_screen.dart';
import 'package:flutter_navigation_practice_1/screens/unknown_screen.dart';

class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {

  Book _selectedBook;
  bool show404 = false;
  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /// ## `Page`
    ///
    /// 當 `Page` 列表有變動，`Navigator` 會更新路徑的堆疊、符合 (match) 路徑
    ///
    /// - Navigator 會根據 `key` 不同，判斷成不同的 `Page`
    final pages = [
      MaterialPage(
        key: ValueKey('BooksListPage'),
        child: BooksListScreen(
          books: books,
          onTapped: _handleBookTapped,
        ),
      ),
      if (show404)
        MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
      else if (_selectedBook != null)
        BookDetailsPage(
          book: _selectedBook
        )
    ];

    /// ## `onPopPage`
    ///
    /// 會在呼叫 `Navigator.pop()` 之後被呼叫
    bool onPopPage(Route<dynamic> route, result) {
      // 1. `didPop` return true if the pop succeeded
      // 2. It’s important to check whether didPop fails before updating the app state.
      if (!route.didPop(result)) {
        return false;
      }

      // Update the list of pages by setting _selectedBook to null
      setState(() {
        _selectedBook = null;
      });

      return true;
    }

    return MaterialApp(
      title: 'Books App',
      home: Navigator(
        pages: pages,
        onPopPage: onPopPage,
      ),
    );
  }

  void _handleBookTapped(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }
}