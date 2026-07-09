import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpatialTrainingScreen extends StatelessWidget {
  const SpatialTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => context.go('/discover'),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.explore, color: Colors.white, size: 60),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Spatial Training',
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
