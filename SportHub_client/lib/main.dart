import 'package:SportHub_client/screens/login_screen.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthorized = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("username") != null) {
    isAuthorized = true;
    SharedPrefs.username = prefs.getString("username");
    SharedPrefs.userId = prefs.getString("userId");
    SharedPrefs.token = prefs.getString("token");
    SharedPrefs.isAdmin = prefs.getBool("isAdmin");
  }
//делать сразу гет запрос на userinfo и сохранять все в бд
  runApp(MaterialApp(home: isAuthorized ? BottomNavScreen() : LoginScreen()));
}
