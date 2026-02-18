class AuthState {
  const AuthState({required this.isAuthenticated});

  final bool isAuthenticated;

  AuthState copyWith({bool? isAuthenticated}) {
    return AuthState(isAuthenticated: isAuthenticated ?? this.isAuthenticated);
  }
}
