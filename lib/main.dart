import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop/routes.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/profile/profile_screen.dart';
import 'package:shop/screens/splash/splash_screen.dart';
import 'package:shop/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Future<int?> cekStatus() async {
    SharedPreferences status = await SharedPreferences.getInstance();
    print(status.getInt('status'));
    return status.getInt('status');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
