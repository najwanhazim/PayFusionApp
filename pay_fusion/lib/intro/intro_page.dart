import 'package:flutter/material.dart';
import 'intro_business_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key, this.onNext}) : super(key: key);

  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Welcome to PayFusion',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Image.asset(
                  'lib/img/intro.png',
                  width: 240,
                  height: 240,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "All-in-one payments for everyone — whether you're a local business, a tourist, or just want to make an impact.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Positioned(
              bottom: 32,
              right: 24,
              child: ElevatedButton(
                onPressed: onNext ?? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const IntroBusinessPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 