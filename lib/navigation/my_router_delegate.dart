import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/models/book.dart';
import 'package:flutter_navigation_practice_1/navigation/transitions/no_animation_transition_delegate.dart';
import 'package:flutter_navigation_practice_1/screens/book_details_screen.dart';
import 'package:flutter_navigation_practice_1/screens/book_list_screen.dart';
import 'package:flutter_navigation_practice_1/screens/unknown_screen.dart';

import 'app_config.dart';

/// The generic type defined on RouterDelegate is BookRoutePath, which
/// contains all the state needed to decide which pages to show.
///
/// In this example, the app state is stored directly on the RouterDelegate,
/// but could also be separated into another class.
class MyRouterDelegate extends RouterDelegate<AppConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfig> {
  final GlobalKey<NavigatorState> navigatorKey;

  Book _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  /// In order to show the correct path in the URL, we need to return a
  /// BookRoutePath based on the current state of the app
  AppConfig get currentConfiguration {
    if (show404) {
      return AppConfig.unknown();
    }
    return _selectedBook == null
        ? AppConfig.home()
        : AppConfig.details(books.indexOf(_selectedBook));
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
        BookDetailsPage(book: _selectedBook),
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
      _selectedBook = null;
      show404 = false;
      notifyListeners();

      return true;
    }
    
    TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: onPopPage,
      transitionDelegate: transitionDelegate,
    );
  }

  /// When a new route has been pushed to the application, `Router` calls
  /// `setNewRoutePath`, which gives our app the opportunity to update the
  /// app state based on the changes to the route:
  @override
  Future<void> setNewRoutePath(AppConfig path) async {
    if (path.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[path.id];
    } else {
      _selectedBook = null;
    }

    show404 = false;
  }

  /// The `onPopPage` callback now uses `notifyListeners` instead of
  /// `setState`.
  ///
  /// When the `RouterDelegate` notifies its listeners, the `Router` widget
  /// is likewise notified that the `RouterDelegate's` `currentConfiguration`
  /// has changed and that its `build` method needs to be called again to
  /// build a new `Navigator`.
  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}