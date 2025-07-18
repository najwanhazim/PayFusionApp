import 'package:flutter/material.dart';
import 'package:pay_fusion/enum/current_view_enum.dart';
import 'package:pay_fusion/main.dart';
import 'package:pay_fusion/navigation_bar/bottom_navigation_bar.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            const Text(
              'PayFusion',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _RoleButton(
                    text: 'I am a User',
                    onPressed: () {
                      currentView = CurrentViewEnum.user;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserNavigationBar(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _RoleButton(
                    text: 'I am a Business Owner',
                    onPressed: () {
                      currentView = CurrentViewEnum.business;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserNavigationBar(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _RoleButton(
                    text: 'I Represent a Charity',
                    onPressed: () {
                      currentView = CurrentViewEnum.charity;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserNavigationBar(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _RoleButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
            255,
            11,
            154,
            127,
          ), // Neon/turquoise
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
        ),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
