import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop/routes.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/profile/profile_screen.dart';
import 'package:shop/screens/splash/splash_screen.dart';
import 'package:shop/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    status: prefs.getInt('status'),
  ));
}

class MyApp extends StatefulWidget {
  final int? status;
  MyApp({Key? key, required this.status});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute:
          widget.status == 1 ? HomeScreen.routeName : SplashScreen.routeName,
      routes: routes,
    );
  }
}
