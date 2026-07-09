import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/language_selection_screen.dart';
import '../../features/onboarding/presentation/screens/device_orientation_screen.dart';
import '../../features/onboarding/presentation/screens/spatial_training_screen.dart';
import '../../features/onboarding/presentation/screens/discover_dots_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/language',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/orientation',
      builder: (context, state) => const DeviceOrientationScreen(),
    ),
    GoRoute(
      path: '/spatial',
      builder: (context, state) => const SpatialTrainingScreen(),
    ),
    GoRoute(
      path: '/discover',
      builder: (context, state) => const DiscoverDotsScreen(),
    ),
  ],
);
