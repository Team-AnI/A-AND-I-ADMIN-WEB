sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLoginSucceeded extends AuthEvent {
  const AuthLoginSucceeded();
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
