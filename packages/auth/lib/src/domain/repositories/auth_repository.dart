import '../entities/auth_session.dart';
import '../entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthSession> login({
    required String username,
    required String password,
  });
  Future<String> refresh();
  Future<void> logout();
  Future<AuthUser> me();
}
