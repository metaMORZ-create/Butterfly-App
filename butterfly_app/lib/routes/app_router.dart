import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';

class AppRouter {
  static const initialRoute = '/login';

  static Map<String, WidgetBuilder> get routes => {
    '/login': (_) => const LoginPage(),
    '/home': (_) => const HomePage(),
  };
}
