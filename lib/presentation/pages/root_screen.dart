import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/presentation/pages/four.dart';
import 'package:tengkulak_sayur/presentation/pages/home.dart';
import 'package:tengkulak_sayur/presentation/pages/second.dart';
import 'package:tengkulak_sayur/presentation/pages/third.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _bottomNavIndex = 1;

  final List<Widget> _listWidget = [
    const SecondPage(),
    const MyHomePage(),
    const ThirdPage(),
    const FourPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.dataset_outlined),
      label: "Kategori",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Beranda',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.assignment_outlined),
      label: 'Transaksi',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Profil',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
