import 'package:chat_test/res/assets/assets.gen.dart';
import 'package:chat_test/res/assets/colors.gen.dart';
import 'package:chat_test/screens/balance.dart';
import 'package:chat_test/screens/chat.dart';
import 'package:chat_test/screens/password_recovery.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    BalanceScreen(),
    Text(
      'Shop',
    ),
    ChatScreen(),
    PasswordRecoveryScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: ColorName.color10,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              color: _selectedIndex == 0 ? ColorName.color5 : ColorName.color6,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.shop.svg(
              color: _selectedIndex == 1 ? ColorName.color5 : ColorName.color6,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.sms.svg(
              color: _selectedIndex == 2 ? ColorName.color5 : ColorName.color6,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.person.svg(
              color: _selectedIndex == 3 ? ColorName.color5 : ColorName.color6,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorName.color5,
        onTap: _onItemTapped,
      ),
    );
  }
}
