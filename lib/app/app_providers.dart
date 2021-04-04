import 'package:flutter_navigation_practice_1/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

getProviders() {
  final providers = [
    ChangeNotifierProvider(
      create: (_) => AuthViewModel()
    ),
  ];

  return providers;
}