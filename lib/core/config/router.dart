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
import '../../features/learning/presentation/screens/dashboard_screen.dart';
import '../../features/learning/presentation/screens/lesson_player_screen.dart';

// Placeholder screens for Teacher and Parent isolation
class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text("Teacher Dashboard")));
}

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text("Parent Dashboard")));
}

class PinAuthScreen extends ConsumerWidget {
  final String userType; // 'teacher' or 'parent'
  const PinAuthScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      return Scaffold(
          body: Center(
              child: ElevatedButton(
                  onPressed: () {
                      if (userType == 'teacher') {
                          ref.read(authProvider.notifier).authenticateTeacher("1234");
                      } else {
                          ref.read(authProvider.notifier).authenticateParent("5678");
                      }
                  },
                  child: Text("Authenticate $userType (Mock)")
              )
          )
      );
  }
}

// Global keys for nested routing isolation
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _learnerNavigatorKey = GlobalKey<NavigatorState>();
final _teacherNavigatorKey = GlobalKey<NavigatorState>();
final _parentNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  // Use a redirect that reads the current state rather than watching it directly
  // to avoid recreating the GoRouter instance.
  // A refreshListenable should ideally be attached if using GoRouter's built-in refresh.

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding Branch
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
        path: '/profile-setup',
        builder: (context, state) => const LearnerProfileScreen(),
      ),

      // Learner Branch (Isolated)
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

      // Teacher Branch (Requires Auth, Isolated)
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
                 if (!ref.read(authProvider).isTeacherAuthenticated) {
                     return '/auth/teacher';
                 }
                 return null;
             }
          ),
        ]
      ),

      // Parent Branch (Requires Auth, Isolated)
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
                 if (!ref.read(authProvider).isParentAuthenticated) {
                     return '/auth/parent';
                 }
                 return null;
             }
          ),
        ]
      ),
    ],
    // Redirect globally if auth state changes while sitting on an auth screen
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
