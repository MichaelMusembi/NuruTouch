import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeviceOrientationScreen extends StatelessWidget {
  const DeviceOrientationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => context.go('/spatial'),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.lock, color: Colors.white, size: 40),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Device Orientation',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
