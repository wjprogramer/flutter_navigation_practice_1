import 'package:equatable/equatable.dart';

/// The `RouteInformationParser` parses the route information into a
/// user-defined data type
///
/// In this app, all of the routes in the app can be represented using a
/// single class. Instead, you might choose to use different classes that
/// implement a superclass, or manage the route information in another way.
class AppConfig extends Equatable {
  final int bookId;
  final Uri uri;

  AppConfig.user()
      : uri = Uri(path: "/user"),
        bookId = null;

  AppConfig.book()
      : uri = Uri(path: "/book"),
        bookId = null;

  AppConfig.bookDetail(this.bookId)
      : uri = Uri(path: "/book/${bookId.toString()}");

  AppConfig.unknown()
      : uri = Uri(path: "/unknown"),
        bookId = null;

  bool get isUserSection => (uri == AppConfig.user().uri);

  bool get isBookSection => (uri == AppConfig.book().uri);

  bool get isBookDetailSection => (bookId != null);

  bool get isUnknown => (uri == AppConfig.unknown().uri);

  @override
  String toString() {
    return "AppConfig{ uriPath : " + uri.path + ", book id : " + bookId
        .toString() + "}";
  }

  @override
  List<Object> get props => [uri.path, bookId];
}
