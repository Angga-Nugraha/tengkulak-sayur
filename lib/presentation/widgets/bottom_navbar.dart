import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/presentation/pages/profile_page.dart';
import 'package:tengkulak_sayur/presentation/pages/home_page.dart';
import 'package:tengkulak_sayur/presentation/pages/category_page.dart';
import 'package:tengkulak_sayur/presentation/pages/transaction_page.dart';

class RootScreen extends StatefulWidget {
  final String uuid;
  const RootScreen({required this.uuid, super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _bottomNavIndex = 1;

  List<Widget> _listWidget() => [
        const CategoryPage(),
        const MyHomePage(),
        const TransactionPage(),
        ProfilePage(uuid: widget.uuid),
      ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.dataset_outlined),
      label: "Category",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.assignment_outlined),
      label: 'Transaction',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Account',
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
