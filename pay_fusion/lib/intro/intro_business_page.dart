import 'package:flutter/material.dart';
import '../role_selection_page.dart';

class IntroBusinessPage extends StatelessWidget {
  const IntroBusinessPage({Key? key, this.onNext}) : super(key: key);

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
                  'PayFusion Business',
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
                  'lib/img/intro_2.png',
                  width: 240,
                  height: 240,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Turn your stall, shop, or service into a fully digital business — in minutes.',
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
                      builder: (context) => const RoleSelectionPage(),
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