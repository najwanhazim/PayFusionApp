import 'package:flutter/material.dart';

class EkycPage extends StatelessWidget {
  const EkycPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'e-KYC',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LoadingCircle(color: Colors.blue),
              const SizedBox(width: 8),
              _LoadingCircle(color: Colors.green),
              const SizedBox(width: 8),
              _LoadingCircle(color: Colors.orange),
            ],
          ),
          const SizedBox(height: 24),
          Image.asset(
            'assets/eKYC.png',
            width: MediaQuery.of(context).size.width * 0.7,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class _LoadingCircle extends StatefulWidget {
  final Color color;
  const _LoadingCircle({required this.color});

  @override
  State<_LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<_LoadingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}