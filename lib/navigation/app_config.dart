/// The `RouteInformationParser` parses the route information into a
/// user-defined data type
///
/// In this app, all of the routes in the app can be represented using a
/// single class. Instead, you might choose to use different classes that
/// implement a superclass, or manage the route information in another way.
class AppConfig {
  final int id;
  final bool isUnknown;

  AppConfig.home()
      : id = null,
        isUnknown = false;

  AppConfig.details(this.id) : isUnknown = false;

  AppConfig.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
