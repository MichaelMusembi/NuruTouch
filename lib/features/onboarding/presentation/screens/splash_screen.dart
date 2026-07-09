import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/language');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: GestureDetector(
        // Hidden entry points for Parent/Teacher auth screens
        onLongPress: () => context.push('/auth/teacher'),
        onDoubleTap: () => context.push('/auth/parent'),
        child: Center(
          child: localizationAsyncValue.when(
            data: (localizationService) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                       Positioned(
                        top: 35,
                        left: 25,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        )
                      ),
                      Positioned(
                        top: 35,
                        right: 25,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        )
                      )
                    ],
                  )
                ),
                const SizedBox(height: 20),
                Text(
                  localizationService.getOnboarding('splash_title'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  localizationService.getOnboarding('splash_subtitle'),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            loading: () => const CircularProgressIndicator(color: Colors.white),
            error: (_, __) => const Text('Error loading translations', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
