import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'constent.dart';
import 'home.dart';
import 'loginpage.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    title: "Knowledge",
    home: Constants.prefs.getBool("loggedIn")== true ? Home():LoginPage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    routes: {
      "/login": (context)  => LoginPage(),
      "/home": (context) => Home()
    },
  ));
}

