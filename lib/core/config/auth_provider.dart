import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isTeacherAuthenticated;
  final bool isParentAuthenticated;

  AuthState({this.isTeacherAuthenticated = false, this.isParentAuthenticated = false});

  AuthState copyWith({bool? isTeacherAuthenticated, bool? isParentAuthenticated}) {
    return AuthState(
      isTeacherAuthenticated: isTeacherAuthenticated ?? this.isTeacherAuthenticated,
      isParentAuthenticated: isParentAuthenticated ?? this.isParentAuthenticated,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState();

  void authenticateTeacher(String pin) {
    if (pin == "1234") {
      state = state.copyWith(isTeacherAuthenticated: true);
    }
  }

  void authenticateParent(String pin) {
    if (pin == "5678") {
      state = state.copyWith(isParentAuthenticated: true);
    }
  }

  void logout() {
      state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() => AuthNotifier());
