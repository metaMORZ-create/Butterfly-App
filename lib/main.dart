import 'package:butterfly_app/pages/home_page.dart';
import 'package:butterfly_app/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool("loggedIn") ?? false;

  

  runApp(MyApp(loggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool loggedIn;

  const MyApp({
    super.key,
    required this.loggedIn,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          widget.loggedIn
              ? HomePage()
              : IntroPage(),
    );
  }
}
