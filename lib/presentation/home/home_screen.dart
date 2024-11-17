import 'package:flutter/material.dart';
import 'package:xtra_pr_71/presentation/home/dashboard/dashbaord_screen.dart';
import 'package:xtra_pr_71/presentation/home/internet/internet_screen.dart';
import 'package:xtra_pr_71/presentation/home/router/router_screen.dart';
import 'package:xtra_pr_71/presentation/home/wireless/wireless_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    InternetScreen(),
    WirelessScreen(),
    RouterScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: buildHomeBottomNavigationBar(),
    );
  }

  Widget buildHomeBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cell_tower),
          label: 'Internet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wifi),
          label: 'Wireless',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.router),
          label: 'Router',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
