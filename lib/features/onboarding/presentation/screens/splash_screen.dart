import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/localization_provider.dart';
import '../../../../core/design/design_tokens.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/language');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationAsyncValue = ref.watch(localizationServiceProvider);

    return Scaffold(
      backgroundColor: DesignTokens.colorPrimary,
      body: GestureDetector(
        onLongPress: () => context.push('/auth/teacher'),
        onDoubleTap: () => context.push('/auth/parent'),
        child: Center(
          child: localizationAsyncValue.when(
            data: (loc) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSmiley(),
                const SizedBox(height: 30),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                    children: [
                      TextSpan(text: 'Nuru', style: TextStyle(color: DesignTokens.colorAccent)),
                      TextSpan(text: 'Touch', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                Text(
                  loc.getOnboarding('splash_subtitle'),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                )
              ],
            ),
            loading: () => const CircularProgressIndicator(color: Colors.white),
            error: (_, __) => const Text('Error', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildSmiley() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: DesignTokens.colorAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: DesignTokens.colorAccent.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 10,
          )
        ]
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50,
            left: 35,
            child: Container(width: 12, height: 12, decoration: const BoxDecoration(color: DesignTokens.colorDotInactive, shape: BoxShape.circle)),
          ),
          Positioned(
            top: 50,
            right: 35,
            child: Container(width: 12, height: 12, decoration: const BoxDecoration(color: DesignTokens.colorDotInactive, shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }
}
