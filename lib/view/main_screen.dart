import 'package:flutter/material.dart';
import 'package:manage_app/view/task/task_screen.dart';

import 'account/account_screen.dart';
import 'home/home_screen.dart';
import 'notification_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List pages=[
    HomeScreen(),
    TaskScreen(),
    NotificationScreen(),
    AccountScreen()
  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items:
        const[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Tác vụ'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Thông báo'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tài khoản'
          ),
        ],
      ),
    );
  }
}
