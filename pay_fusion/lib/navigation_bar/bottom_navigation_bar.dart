import 'package:flutter/material.dart';
import 'package:pay_fusion/pages/budget_donut_page.dart';
import 'package:pay_fusion/enum/current_view_enum.dart';
import 'package:pay_fusion/main.dart';
import 'package:pay_fusion/pages/ekyc_page.dart';
import 'package:pay_fusion/pages/home_page_bank.dart';
import 'package:pay_fusion/pages/home_page_card.dart';
import 'package:pay_fusion/pages/invoice_page.dart';

class UserNavigationBar extends StatefulWidget {
  const UserNavigationBar({super.key});

  @override
  State<UserNavigationBar> createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  int _selectedIndex = 0;

  List<Widget> get _pages => <Widget>[
    currentView == CurrentViewEnum.user ? HomePageCard() : HomePageBank(),
    const Center(child: Text('QR')),
    currentView == CurrentViewEnum.business
        ? const InvoicePage()
        : const BudgetDonutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
        shape: const CircleBorder(),
        backgroundColor:
            _selectedIndex == 1 ? const Color(0xFF01BBB9) : Colors.white,
        child: Icon(
          Icons.qr_code_scanner,
          color: _selectedIndex == 1 ? Colors.white : Colors.black,
          size: 30.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF01BBB9),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: ''),
        ],
      ),
    );
  }
}
