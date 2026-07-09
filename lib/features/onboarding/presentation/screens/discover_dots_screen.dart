import 'package:flutter/material.dart';

class DiscoverDotsScreen extends StatelessWidget {
  const DiscoverDotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Dots', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(),
                _buildDot(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(),
                _buildDot(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDot(),
                _buildDot(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xFF1a1c29),
        shape: BoxShape.circle,
      ),
    );
  }
}
