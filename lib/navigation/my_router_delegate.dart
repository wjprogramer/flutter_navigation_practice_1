import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/models/book.dart';
import 'package:flutter_navigation_practice_1/navigation/transitions/no_animation_transition_delegate.dart';
import 'package:flutter_navigation_practice_1/screens/book_details_screen.dart';
import 'package:flutter_navigation_practice_1/screens/book_list_screen.dart';
import 'package:flutter_navigation_practice_1/screens/unknown_screen.dart';
import 'package:flutter_navigation_practice_1/screens/user_screen.dart';

import 'app_config.dart';

/// The generic type defined on RouterDelegate is BookRoutePath, which
/// contains all the state needed to decide which pages to show.
///
/// In this example, the app state is stored directly on the RouterDelegate,
/// but could also be separated into another class.
class MyRouterDelegate extends RouterDelegate<AppConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfig> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppConfig currentState = AppConfig.book();
  AppConfig previousState;

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    print("1. BookRouterDelegate initialized");
    print(this);
    assert(AppConfig.book() == this.currentConfiguration);
  }

  /// In order to show the correct path in the URL, we need to return a
  /// BookRoutePath based on the current state of the app
  AppConfig get currentConfiguration => currentState;

  List<Page<dynamic>> buildPage() {
    List<Page<dynamic>> pages = [];
    pages.add(
      MaterialPage(
        key: ValueKey('BooksListPage'),
        child: BooksListScreen(
          books: books,
        ),
      ),
    );
    if (currentState.uri.pathSegments[0] ==
        AppConfig.book().uri.pathSegments[0]) {
      if (currentState.bookId != null)
        pages.add(
          MaterialPage(
              key: ValueKey('BookListPageId' + currentState.bookId.toString()),
              child: BookDetailsScreen(book: books[currentState.bookId])),
        );
    } else if (currentState.uri.pathSegments[0] ==
        AppConfig.user().uri.pathSegments[0]) {
      pages.add(MaterialPage(
          key: ValueKey('LoginScreen'),
          child: UserScreen(
            refresh: _notifyListeners,
          )));
    }
    if (currentState.isUnknown)
      pages.add(
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen()));
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    print("BookRouterDelegate building...");
    print(this.currentState);

    bool onPopPage(Route<dynamic> route, result) {
      if (!route.didPop(result)) {
        return false;
      } else if (currentState.uri.pathSegments[0] ==
          AppConfig.book().uri.pathSegments[0] &&
          currentState.bookId != null) {
        currentState = AppConfig.book();
      } else if (currentState.uri.path == AppConfig.user().uri.path) {
        currentState = previousState;
        previousState = null;
      } else {
        currentState = AppConfig.unknown();
      }
      notifyListeners();
      return true;
    }
    
    // TransitionDelegate transitionDelegate = NoAnimationTransitionDelegate();

    return Navigator(
      key: navigatorKey,
      pages: buildPage(),
      onPopPage: onPopPage,
      // transitionDelegate: transitionDelegate,
    );
  }

  /// When a new route has been pushed to the application, `Router` calls
  /// `setNewRoutePath`, which gives our app the opportunity to update the
  /// app state based on the changes to the route:
  @override
  Future<void> setNewRoutePath(AppConfig newState) async {
    currentState = newState;
    return;
  }

  void handleBookTapped(Book book) {
    currentState = AppConfig.bookDetail(books.indexOf(book));
    notifyListeners();
  }

  void handleUserTapped(void _) {
    previousState = currentState;
    currentState = AppConfig.user();
    notifyListeners();
  }

  void _notifyListeners(void nothing) {
    notifyListeners();
  }
}