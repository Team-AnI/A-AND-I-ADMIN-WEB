import '../entities/auth_session.dart';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

final class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String username,
    required String password,
  }) {
    return _repository.login(username: username, password: password);
  }
}

final class RefreshUseCase {
  const RefreshUseCase(this._repository);

  final AuthRepository _repository;

  Future<String> call() => _repository.refresh();
}

final class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}

final class MeUseCase {
  const MeUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call() => _repository.me();
}
