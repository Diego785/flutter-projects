import 'package:provider/provider.dart';
import 'package:terminal_bimodal/src/connection/server.dart';
import 'package:terminal_bimodal/src/screens/auth/auth.dart';
import 'package:terminal_bimodal/src/screens/buses/show_buses.dart';
import 'package:terminal_bimodal/src/screens/chofers/show_chofer.dart';
import 'package:terminal_bimodal/src/screens/home/dashboard.dart';
import 'package:terminal_bimodal/src/screens/auth/login.dart';
import 'package:terminal_bimodal/src/screens/auth/register.dart';
import 'package:terminal_bimodal/src/screens/users/show_user.dart';
import 'package:terminal_bimodal/src/screens/auth/login2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terminal_bimodal/src/screens/users/show_user2.dart';
import 'package:terminal_bimodal/src/screens/welcome/welcome_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green[800],
          primaryColorLight: Colors.green[800],
          accentColor: Colors.green[800],
          cardColor: Colors.grey[100],
          focusColor: Colors.grey[100],
          cursorColor: Colors.green[800],
          indicatorColor: Colors.green[800],
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white))),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return Drawer(
                  child: Consumer<Auth>(builder: (context, auth, child) {
                if (!auth.authenticated) {
                  return WelcomePage();
                } else {
                  return Dashboard();
                }
              }));
            case '/login':
              return LoginPage2();
            case '/register':
              return RegisterPage();
            case '/home':
              return Dashboard();
            case '/user':
              return ShowUserPage();
            case '/chofer':
              return ShowChoferPage();
            case '/bus':
              return ShowBusPage();
            case '/user2':
              return ShowUserPage2();
            case '/usersApi':
              return Connection();
          }
          return Text("Null");
        });
      },
    );
  }
}
