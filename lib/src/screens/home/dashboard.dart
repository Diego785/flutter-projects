import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar.dart';
import 'package:terminal_bimodal/src/screens/navigation/nav_bar2.dart';
import 'package:terminal_bimodal/src/screens/welcome/welcome_page.dart';
import 'package:terminal_bimodal/src/screens/home/nav_pages/bar_item_page.dart';
import 'package:terminal_bimodal/src/screens/home/nav_pages/home_page.dart';
import 'package:terminal_bimodal/src/screens/home/nav_pages/my_page.dart';
import 'package:terminal_bimodal/src/screens/home/nav_pages/search_page.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    try {
      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).tryToken(token!);
      print(token);
    } catch (e) {
      print(e);
    }
  }

  List pages = [
    HomePage(),
    BarItemPage(),
    SearchPage(),
    MyPage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar2(),
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green.shade800,
      ),
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 9,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[800],
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_sharp),
            label: "Bar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My",
          ),
        ],
      ),
    );
  }
}
