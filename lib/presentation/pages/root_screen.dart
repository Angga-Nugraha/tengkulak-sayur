import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/presentation/pages/profile_page.dart';
import 'package:tengkulak_sayur/presentation/pages/home_page.dart';
import 'package:tengkulak_sayur/presentation/pages/category_page.dart';
import 'package:tengkulak_sayur/presentation/pages/third.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({required this.user, super.key});
  final User user;
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _bottomNavIndex = 1;

  List<Widget> _listWidget() => [
        const CategoryPage(),
        MyHomePage(user: widget.user),
        const ThirdPage(),
        ProfilePage(user: widget.user)
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
    final List<Widget> listWidget = _listWidget();
    return Scaffold(
      body: listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
