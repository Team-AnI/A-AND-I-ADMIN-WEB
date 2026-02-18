import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_event.dart';
import 'auth_state.dart';

part 'auth_bloc.g.dart';

@riverpod
class AuthBloc extends _$AuthBloc {
  @override
  AuthState build() => const AuthState(isAuthenticated: false);

  void onEvent(AuthEvent event) {
    switch (event) {
      case AuthLoginSucceeded():
        state = state.copyWith(isAuthenticated: true);
      case AuthLogoutRequested():
        state = state.copyWith(isAuthenticated: false);
    }
  }
}
