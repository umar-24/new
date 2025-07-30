import 'package:brand/screens/add_post_screen.dart';
import 'package:brand/screens/forgot_password.dart';
import 'package:brand/screens/home_screen.dart';
import 'package:brand/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    PostScreen(),
    AddPostsScreen(),
    ProfileScreen(),
  ];

  void onTappedItem(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedItem,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Post"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ]),
    );
  }
}