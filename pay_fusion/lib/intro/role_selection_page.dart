import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A1B),
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
                  _RoleButton(text: 'I am a User', onPressed: () {}),
                  const SizedBox(height: 20),
                  _RoleButton(text: 'I am a Business Owner', onPressed: () {}),
                  const SizedBox(height: 20),
                  _RoleButton(text: 'I Represent a Charity', onPressed: () {}),
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
          backgroundColor: const Color(0xFF19C6AC),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
} 