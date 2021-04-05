import 'package:flutter/material.dart';
import 'package:flutter_navigation_practice_1/core/authentication/authentication_manager.dart';
import 'package:flutter_navigation_practice_1/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T> {

  bool _hasFirstBuilt = false;

  AuthViewModel authViewModel;

  @protected
  Color get backgroundColor => Theme.of(context).backgroundColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _hasFirstBuilt = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = context.watch<AuthViewModel>();

    return Consumer<AuthViewModel>(
      builder: (_, auth, __) => Scaffold(
        backgroundColor: this.backgroundColor,
        appBar: this.buildAppBar(context),
        body: Consumer<AuthViewModel>(
          builder: (_, auth, __) {
            if (_hasFirstBuilt) {
              if (AuthenticationManager.instance.isLoggedIn) {
                this.onLoggedIn();
              } else {
                this.onLoggedOut();
              }
            }
            return this.buildScreen(context);
          },
        ),
        bottomNavigationBar: this.buildBottomNavigationBar(context),
        floatingActionButton: this.buildFloatingActionButton(context),
      ),
    );
  }

  Widget buildScreen(BuildContext context);

  ///
  /// Implement this to build an [AppBar] for all screens
  /// Override this method in each screen that needs a specific one
  ///
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return null;
  }

  ///
  /// Implement this to build a [BottomNavigationBar] for all screens
  /// Override this method in each screen that needs a specific one
  ///
  Widget buildBottomNavigationBar(BuildContext context) {
    return null;
  }

  ///
  /// Implement this to build a [FloatingActionButton] for all screens
  /// Override this method in each screen that needs a specific one
  ///
  Widget buildFloatingActionButton(BuildContext context) {
    return null;
  }

  ///
  /// Default back navigation behavior
  ///
  void goBack() {
    Navigator.pop(context);
  }

  ///
  /// Sends a log in event
  ///
  void doLogin() {
    authViewModel.login();
  }

  ///
  /// Sends a logout event
  ///
  void doLogout() {
    authViewModel.logout();
  }

  ///
  /// Logout event has completed
  /// Clear all navigation history and push login page
  /// Override this method to implement how the app should behave
  /// once a user has been logged out
  ///
  void onLoggedOut() {}

  ///
  /// Log in event has completed
  /// Override this method to implement how the app should behave
  /// once a user has been logged in
  ///
  void onLoggedIn() {}
}
