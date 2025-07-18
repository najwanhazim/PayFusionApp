import 'package:flutter/material.dart';
import 'package:pay_fusion/pages/budget_donut_page.dart';
import 'package:pay_fusion/enum/current_view_enum.dart';
import 'package:pay_fusion/main.dart';
import 'package:pay_fusion/pages/business/business_form.dart';
import 'package:pay_fusion/pages/charity/charity_form.dart';
import 'package:pay_fusion/pages/ekyc_page.dart';
import 'package:pay_fusion/pages/home_page_bank.dart';
import 'package:pay_fusion/pages/home_page_card.dart';
import 'package:pay_fusion/pages/qr/qr_scan_page.dart';
import 'package:pay_fusion/pages/AIchatbot/ai_chat_page.dart';
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
    QRScanPage(),
    currentView == CurrentViewEnum.business
        ? const InvoicePage()
        : const BudgetDonutPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _showProfilePrompt({
  required String title,
  required String message,
  required Widget nextPage,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => nextPage),
            );
          },
          child: const Text("Continue"),
        ),
      ],
    ),
  );
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 2) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (currentView == CurrentViewEnum.business && hasIsiBusiness == false) {
      _showProfilePrompt(
        title: "Complete Your Business Profile",
        message: "Please fill out the business form to continue.",
        nextPage: const BusinessFormPage(),
      );
    } else if (currentView == CurrentViewEnum.charity && hasIsiCharity == false) {
      _showProfilePrompt(
        title: "Complete Your Charity Profile",
        message: "Please fill out the charity form to continue.",
        nextPage: const CharityFormPage(),
      );
    }
  });
}

    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                shape: const CircleBorder(),
                backgroundColor:
                    _selectedIndex == 1
                        ? const Color(0xFF01BBB9)
                        : Colors.white,
                child: Icon(
                  Icons.qr_code_scanner,
                  color: _selectedIndex == 1 ? Colors.white : Colors.black,
                  size: 30.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 74, right: 14),
              child: FloatingActionButton(
                heroTag: 'aiChat',
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const AiChatPage()));
                },
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Color(0xFF01BBB9),
                  size: 28.0,
                ),
              ),
            ),
          ),
        ],
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
