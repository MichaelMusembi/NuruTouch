import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/language_selection_screen.dart';
import '../../features/onboarding/presentation/screens/device_orientation_screen.dart';
import '../../features/onboarding/presentation/screens/spatial_training_screen.dart';
import '../../features/onboarding/presentation/screens/discover_dots_screen.dart';
import '../../features/onboarding/presentation/screens/learner_profile_screen.dart';
import '../../features/onboarding/presentation/screens/adventure_begins_screen.dart';
import '../../features/onboarding/presentation/screens/voice_enrollment_screen.dart';
import '../../features/onboarding/presentation/screens/gesture_tutorial_screen.dart';

import '../../features/learning/presentation/screens/dashboard_screen.dart';
import '../../features/learning/presentation/screens/lesson_player_screen.dart';
import '../../features/parent/presentation/screens/pin_auth_screen.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Teacher')), body: const Center(child: Text("Teacher Dashboard")));
}

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Parent')), body: const Center(child: Text("Parent Dashboard")));
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _learnerNavigatorKey = GlobalKey<NavigatorState>();
final _teacherNavigatorKey = GlobalKey<NavigatorState>();
final _parentNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      GoRoute(
        path: '/gesture-tap',
        builder: (context, state) => const GestureTutorialScreen(isSwipeTutorial: false),
      ),
      GoRoute(
        path: '/gesture-swipe',
        builder: (context, state) => const GestureTutorialScreen(isSwipeTutorial: true),
      ),
      GoRoute(
        path: '/voice-enrollment',
        builder: (context, state) => const VoiceEnrollmentScreen(),
      ),
      GoRoute(
        path: '/adventure-begins',
        builder: (context, state) => const AdventureBeginsScreen(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const LearnerProfileScreen(),
      ),

      ShellRoute(
        navigatorKey: _learnerNavigatorKey,
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
           GoRoute(
             path: '/learner/home',
             builder: (context, state) => const DashboardScreen(),
           ),
           GoRoute(
             path: '/learner/lesson',
             builder: (context, state) => const LessonPlayerScreen(),
           ),
        ]
      ),

      GoRoute(
        path: '/auth/teacher',
        builder: (context, state) => const PinAuthScreen(userType: 'teacher'),
      ),
      ShellRoute(
        navigatorKey: _teacherNavigatorKey,
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          GoRoute(
             path: '/teacher/dashboard',
             builder: (context, state) => const TeacherDashboard(),
             redirect: (context, state) {
                 if (!ref.read(authProvider).isTeacherAuthenticated) return '/auth/teacher';
                 return null;
             }
          ),
        ]
      ),

      GoRoute(
        path: '/auth/parent',
        builder: (context, state) => const PinAuthScreen(userType: 'parent'),
      ),
      ShellRoute(
        navigatorKey: _parentNavigatorKey,
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          GoRoute(
             path: '/parent/dashboard',
             builder: (context, state) => const ParentDashboard(),
             redirect: (context, state) {
                 if (!ref.read(authProvider).isParentAuthenticated) return '/auth/parent';
                 return null;
             }
          ),
        ]
      ),
    ],
    redirect: (context, state) {
        final authState = ref.read(authProvider);
        if (state.matchedLocation == '/auth/teacher' && authState.isTeacherAuthenticated) {
            return '/teacher/dashboard';
        }
        if (state.matchedLocation == '/auth/parent' && authState.isParentAuthenticated) {
            return '/parent/dashboard';
        }
        return null;
    }
  );
});
